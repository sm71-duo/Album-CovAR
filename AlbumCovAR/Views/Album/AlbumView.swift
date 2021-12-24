//
//  SwiftUIView.swift
//  AlbumCovAR
//
//  Created by Quan on 24/12/2021.
//

import SwiftUI

struct AlbumView: View {
    
    var album: Album
    
    var body: some View {
        ZStack{
            
            AlbumBackgroundComponent(album: album)
            
            Text(album.name).foregroundColor(album.contrastColor)
            
        }.ignoresSafeArea()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album.sampleData[4])
    }
}
