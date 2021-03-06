//
//  ContentView.swift
//  ARworkshop
//
//  Created by Roy Appeldoorn on 14/12/2021.
//

import SwiftUI
import RealityKit
import ARKit

class AlbumARViewViewModel : ObservableObject {
    @Published var showBottomSheet: Bool = false
    @Published var currentAlbum: Album = Album.sampleData[0]
}

struct AlbumARView : View {
    @StateObject var viewModel = AlbumARViewViewModel()
    
    @StateObject var albumStoreState = AlbumStore()
    
    @Binding var recentAlbums: [Album]
    
    let testAlbum = Album.sampleData[2]
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            ARViewContainer(currentAlbum: $viewModel.currentAlbum, showBottomSheet: $viewModel.showBottomSheet, recentAlbums: $recentAlbums, albumStoreState: albumStoreState).edgesIgnoringSafeArea(.all)
            
            BottomSheetModal(display: $viewModel.showBottomSheet, backgroundColor: albumStoreState.album.avgColor, indicatorColor: albumStoreState.album.contrastColor) {
                AlbumModalComponent( albumStoreState: albumStoreState)
            }
        }
    }
}
