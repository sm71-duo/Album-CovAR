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
    @State private var albumTitle = ""
    
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

    let arView = ARView(frame: .zero)
    @Binding var albumTitle: String
    @Binding var showBottomSheet: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(arView: arView, albumTitleState: $albumTitle, showBottomSheetState: $showBottomSheet)
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

        init(arView: ARView, albumTitleState: Binding<String>, showBottomSheetState: Binding<Bool>) {
            self.arView = arView
            _albumTitle = albumTitleState
            _showBottomSheet = showBottomSheetState
        }

        @objc func handleTap(recognizer: UITapGestureRecognizer) {
            let location = recognizer.location(in: arView)

            if let tappedEntity = arView.entity(at: location) {
                self.showBottomSheet = true
                self.albumTitle = tappedEntity.name
                print("Found album: \(tappedEntity.name)")
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
//                    albumEntity.generateCollisionShapes(recursive: true)

                    let pressable = SimpleMaterial(color: .lightGray.withAlphaComponent(0.0), isMetallic: true)
                    let pressableEntity = ModelEntity(mesh: .generatePlane(width: width / 4, depth: height / 4, cornerRadius: 9999), materials: [pressable])
                    pressableEntity.generateCollisionShapes(recursive: true)
                    pressableEntity.name = anchor.name ?? "'no name found'"
                    pressableEntity.setPosition(SIMD3<Float>(0, 0.05, 0), relativeTo: anchorEntity)

                    anchorEntity.addChild(pressableEntity)
                    anchorEntity.addChild(albumEntity)
                    arView.scene.addAnchor(anchorEntity)

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
