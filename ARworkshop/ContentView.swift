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
            let location = recognizer.location(in: arView)
            
            if let tappedEntity = arView.entity(at: location) {
                print("Tapped anchor with name \(tappedEntity.name)")
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    print("Updated anchor with name \(String(describing: imageAnchor.name) )")
                }
            }
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    
                    let width = Float(imageAnchor.referenceImage.physicalSize.width)
                    let height = Float(imageAnchor.referenceImage.physicalSize.height)
                    
                    let modelEntity = ModelEntity(mesh: .generatePlane(width: width, depth: height), materials: [SimpleMaterial(color: .black, isMetallic: true)])
                    
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
