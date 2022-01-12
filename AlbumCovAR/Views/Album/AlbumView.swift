//
//  SwiftUIView.swift
//  AlbumCovAR
//
//  Created by Quan on 24/12/2021.
//

import SwiftUI

struct AlbumView: View {
    
    var album: Album
    let uiscreen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            
            AlbumBackgroundComponent(album: album)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                }
                
                Text(album.name)
                    .font(.title)
                    .fontWeight(.medium)
                
                ScrollView {
                        ForEach(album.tracklist.songs) {song in
                            SongCellComponent(song: song)
                                .padding(.vertical, 0.2)
                        
                    }
                }
                
                Text(album.artist)
                    .font(.title2)
                    .fontWeight(.medium)
                    .padding(.top, 0.5)
                    .padding(.bottom, 2.5)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(width: self.uiscreen.width)
        }
        .foregroundColor(album.contrastColor)
        .navigationTitle("")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album.sampleData[4])
    }
}
