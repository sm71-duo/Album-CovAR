//
//  ContentView.swift
//  ARworkshop
//
//  Created by Roy Appeldoorn on 14/12/2021.
//

import SwiftUI
import RealityKit
import ARKit

struct AlbumARView : View {
    @State private var showBottomSheet = false
    @State  var albumTitle = ""
    
    let testAlbum = Album.sampleData[2]
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ARViewContainer(albumTitle: $albumTitle, showBottomSheet: $showBottomSheet).edgesIgnoringSafeArea(.all)
            
            Button(action: {
                withAnimation {
                    self.showBottomSheet.toggle()
                }
            }) {
                Text("\(albumTitle)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
            }
            BottomSheetModal(display: $showBottomSheet, backgroundColor: testAlbum.avgColor) {
                AlbumModalView(album: Album.sampleData.first(where: {$0.name == albumTitle}) ?? testAlbum)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    let arView = ARView(frame: .init(x: 1, y: 1, width: 1, height: 1), cameraMode: .ar, automaticallyConfigureSession: false)
    @Binding var albumTitle: String
    @Binding var showBottomSheet: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(arView: arView, albumTitle: $albumTitle, showBottomSheetState: $showBottomSheet)
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
        @Binding var albumTitle: String
        
        @Binding var showBottomSheet: Bool
        
        init(arView: ARView, albumTitle: Binding<String>, showBottomSheetState: Binding<Bool>) {
            self.arView = arView
            _albumTitle = albumTitle
            _showBottomSheet = showBottomSheetState
        }
        
        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            let location = recognizer.location(in: arView)
            
            if let tappedEntity = arView.entity(at: location) {
                showBottomSheet = true
                albumTitle = tappedEntity.name
                print("UPDATE: Found album: \(tappedEntity.name)")
                
            }
        }
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    
                    let anchorEntity = AnchorEntity(anchor: imageAnchor)
                    
                    let width = Float(imageAnchor.referenceImage.physicalSize.width)
                    let height = Float(imageAnchor.referenceImage.physicalSize.height)
                    
                    var albumOverlay = SimpleMaterial()
                    albumOverlay.color = try! .init( texture: .init(.load(named: "\(anchor.name ?? "help") Cover", in: nil)))
                    let albumEntity = ModelEntity(mesh: .generatePlane(width: width * 1.1, depth: height * 1.1, cornerRadius: 0.01), materials: [albumOverlay])
                    albumEntity.name = anchor.name ?? "'no name found'"
                    albumEntity.generateCollisionShapes(recursive: true)
                    
                    
                    anchorEntity.addChild(albumEntity)
                    arView.scene.addAnchor(anchorEntity)
                    
                }
            }
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let imageAnchor = anchor as? ARImageAnchor {
                    if imageAnchor.isTracked{
                        print("UPDATE: tracking")
                    } else {
                        print("UPDATE: removed")
                    }
                }
            }
        }
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        AlbumARView()
    }
}
#endif
