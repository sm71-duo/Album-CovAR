//
//  AlbumComponentView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct AlbumComponentView: View {
    
    var album: Album
    
    var body: some View {
        HStack {
            HStack {
                Image(album.coverImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {Text(album.name)
                        .foregroundColor(Color("White"))
                        .font(.headline)
                        .padding(.horizontal)
                    Text(album.artist)
                        .foregroundColor(Color("White"))
                        .font(.subheadline)
                    .padding(.horizontal)}
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 24))
                .frame(width: 56, height: 56)
                .foregroundColor(Color("White"))
        }
        .padding(.horizontal)
        .listRowBackground(Color("BackgroundColor"))
    }
}

struct AlbumComponentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack {
                AlbumComponentView(album: Album(name: "Flower Boy", artist: "Tyler, the Creator", coverImageName: "FlowerBoyAlbum"))
            }
        }
    }
}
