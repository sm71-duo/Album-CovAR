//
//  SongCellComponent.swift
//  AlbumCovAR
//
//  Created by Quan on 24/12/2021.
//

import SwiftUI

struct SongCellComponent: View {
    
    var song: Song
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text("\(song.trackNumber).")
                    .font(.title2)
                VStack(alignment: .leading){
                    Text(song.name)
                        .font(.headline)
                    HStack {
                        ForEach(song.artist, id: \.self) {artist in
                            if artist == song.artist.last {
                                Text("\(artist)").font(.subheadline)
                            } else {
                                Text("\(artist),").font(.subheadline)
                            }
                        }
                    }
                    
                    
                }
                Spacer()
            }
        }
       
    }
}

struct SongCellComponent_Previews: PreviewProvider {
    static var previews: some View {
        SongCellComponent(song: Album.sampleData[0].tracklist.songs[1])
    }
}
