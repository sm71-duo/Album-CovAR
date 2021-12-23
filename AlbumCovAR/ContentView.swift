//
//  ContentView.swift
//  ARworkshop
//
//  Created by Roy Appeldoorn on 14/12/2021.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let arView = ARView(frame: .zero)
    
    func makeCoordinator() -> Coordinator {
        Coordinator(arView: arView)
    }
    
    func makeUIView(context: Context) -> ARView {
        
        let config = ARImageTrackingConfiguration();
        config.maximumNumberOfTrackedImages = 2
        config.isAutoFocusEnabled = true
        
        guard let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Images not found")
        }
        
        config.trackingImages = trackingImages
        
        arView.session.delegate = context.coordinator
        arView.session.run(config, options: [])
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(recognizer:))))
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    class Coordinator: NSObject, ARSessionDelegate {
        
        let arView: ARView!
        
        init(arView: ARView) {
            self.arView = arView
        }
        
        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            let location = recognizer.location(in: arView)
            
            if let tappedEntity = arView.entity(at: location) {
                print("Found album: \(tappedEntity.name)")
                tappedEntity.removeFromParent()
            }
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    
                    let width = Float(imageAnchor.referenceImage.physicalSize.width)
                    let height = Float(imageAnchor.referenceImage.physicalSize.height)
                    
                    var albumOverlay = SimpleMaterial()
                    albumOverlay.color = try! .init( texture: .init(.load(named: "\(anchor.name ?? "help")Album", in: nil)))
                    let albumEntity = ModelEntity(mesh: .generatePlane(width: width * 1.1, depth: height * 1.1, cornerRadius: 0.01), materials: [albumOverlay])
                    
                    let pressable = SimpleMaterial(color: .lightGray.withAlphaComponent(0.8), isMetallic: true)
                    let pressableEntity = ModelEntity(mesh: .generatePlane(width: width / 4, depth: height / 4, cornerRadius: 9999), materials: [pressable])
                    pressableEntity.generateCollisionShapes(recursive: true)
                    pressableEntity.name = anchor.name ?? "'no name found'"
                    pressableEntity.setPosition(SIMD3<Float>(0, 0.05, 0), relativeTo: anchorEntity)
                    
                    anchorEntity.addChild(albumEntity)
                    anchorEntity.addChild(pressableEntity)
                    
                    arView.scene.addAnchor(anchorEntity)
                    
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
