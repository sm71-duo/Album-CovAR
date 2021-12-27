//
//  AlbumCovarApp.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

@main
struct AlbumCovarApp: App {
    
    @State private var recentAlbums: [Album] =  []
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(recentAlbums: $recentAlbums)
            }
        }
    }
}

