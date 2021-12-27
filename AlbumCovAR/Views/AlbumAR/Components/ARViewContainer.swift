////
////  ARViewContainer.swift
////  AlbumCovAR
////
////  Created by Quan on 24/12/2021.
////
//
//import SwiftUI
//import RealityKit
//import ARKit
//
//struct ARViewContainer: UIViewRepresentable {
//    
//    let arView = ARView(frame: .init(x: 1, y: 1, width: 1, height: 1), cameraMode: .ar, automaticallyConfigureSession: false)
//    
//    @Binding var currentAlbum: Album
//    @Binding var showBottomSheet: Bool
//    @Binding var recentAlbums: [Album]
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(arView: arView, currentAlbum: $currentAlbum, showBottomSheetState: $showBottomSheet, recentAlbums: $recentAlbums)
//    }
//    
//    func makeUIView(context: Context) -> ARView {
//        
//        let config = ARImageTrackingConfiguration();
//        config.maximumNumberOfTrackedImages = 2
//        config.isAutoFocusEnabled = true
//        
//        guard let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
//            fatalError("Images not found")
//        }
//        
//        config.trackingImages = trackingImages
//        
//        arView.session.delegate = context.coordinator
//        arView.session.run(config, options: [])
//        
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(recognizer:))))
//        
//        return arView
//        
//    }
//    
//    func updateUIView(_ uiView: ARView, context: Context) {}
//    
//    class Coordinator: NSObject, ARSessionDelegate {
//        
//        let arView: ARView!
//        @Binding var currentAlbum: Album
//        @Binding var showBottomSheet: Bool
//        @Binding var recentAlbums: [Album]
//        
//        init(arView: ARView, currentAlbum: Binding<Album>, showBottomSheetState: Binding<Bool>, recentAlbums: Binding<[Album]>) {
//            self.arView = arView
//            _currentAlbum = currentAlbum
//            _showBottomSheet = showBottomSheetState
//            _recentAlbums = recentAlbums
//        }
//        
//        @objc func handleTap(recognizer: UITapGestureRecognizer) {
//            let location = recognizer.location(in: arView)
//            
//            if let tappedEntity = arView.entity(at: location) {
//                withAnimation{
//                    showBottomSheet = true
//                }
//                currentAlbum = Album.sampleData.first(where: {$0.name == tappedEntity.name}) ?? Album.sampleData[0]
//                recentAlbums.append(currentAlbum)
//                print("UPDATE: Found album: \(tappedEntity.name)")
//                
//            }
//        }
//        
//        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//            for anchor in anchors {
//                if let imageAnchor = anchor as? ARImageAnchor {
//                    
//                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
//                    
//                    let width = Float(imageAnchor.referenceImage.physicalSize.width)
//                    let height = Float(imageAnchor.referenceImage.physicalSize.height)
//                    
//                    var albumOverlay = SimpleMaterial()
//                    albumOverlay.color = try! .init( texture: .init(.load(named: "\(anchor.name ?? "help") Cover", in: nil)))
//                    let albumEntity = ModelEntity(mesh: .generatePlane(width: width * 1.1, depth: height * 1.1, cornerRadius: 0.01), materials: [albumOverlay])
//                    albumEntity.name = anchor.name ?? "'no name found'"
//                    albumEntity.generateCollisionShapes(recursive: true)
//                    
//                    
//                    anchorEntity.addChild(albumEntity)
//                    arView.scene.addAnchor(anchorEntity)
//                    
//                }
//            }
//        }
//        
//        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
//            for anchor in anchors {
//                if let imageAnchor = anchor as? ARImageAnchor {
//                    if imageAnchor.isTracked{
//                        print("UPDATE: tracking")
//                    } else {
//                        print("UPDATE: removed")
//                    }
//                }
//            }
//        }
//    }
//}
