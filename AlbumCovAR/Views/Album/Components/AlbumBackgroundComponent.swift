//
//  AlbumBackgroundComponent.swift
//  AlbumCovAR
//
//  Created by Quan on 24/12/2021.
//

import SwiftUI

struct AlbumBackgroundComponent: View {
    
    var album: Album
    
    var body: some View {
        ZStack {
            Image(album.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Rectangle().fill(LinearGradient(gradient: Gradient(colors: [album.avgColor, album.avgColor.opacity(0.0)]), startPoint: .init(x: 0.45, y: 0.5), endPoint: .trailing))
            
        }
    }
}

struct AlbumBackgroundComponent_Previews: PreviewProvider {
    static var previews: some View {
        AlbumBackgroundComponent(album: Album.sampleData[7])
    }
}
