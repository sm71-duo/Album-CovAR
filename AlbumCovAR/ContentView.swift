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
        return ARViewContainer().edgesIgnoringSafeArea(.all)
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
        var avPlayer: AVPlayer?
        
        init(arView: ARView) {
            self.arView = arView
        }
        
        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            print("yeet")
            let location = recognizer.location(in: arView)
            
            if let tappedEntity = arView.entity(at: location) {
                print("got em, \(tappedEntity.name)")
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
//                    print("Updated anchor with name \(String(describing: imageAnchor.name) )")
                } else {
                    print("Updated anchor not found")
                }
            }
        }
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    
                    let width = Float(imageAnchor.referenceImage.physicalSize.width)
                    let height = Float(imageAnchor.referenceImage.physicalSize.height)
                    
                    let material = SimpleMaterial(color: .lightGray.withAlphaComponent(0.8), isMetallic: true)
                    
                    let modelEntity = ModelEntity(mesh: .generatePlane(width: width / 3, depth: height / 3, cornerRadius: width), materials: [material])
                    
                    modelEntity.generateCollisionShapes(recursive: true)
                                        
                    modelEntity.name = "gangster"
                    
                    anchorEntity.addChild(modelEntity)
                    
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
