//
//  AlbumModalView.swift
//  AlbumCovAR
//
//  Created by Quan on 23/12/2021.
//

import SwiftUI

struct AlbumModalComponent: View {
    
    var album: Album
    
    let uiscreen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            ZStack {
                Image(album.coverImageName)
                        .resizable()
                        .scaledToFit()

                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [album.avgColor, album.avgColor.opacity(0.0)]), startPoint: .init(x: 0.4, y: 0.4), endPoint: .trailing))
            }
                .frame(width: self.uiscreen.width,
                          height: self.uiscreen.width,
                          alignment: .center)
            VStack(alignment: .leading) {
                HStack{
                    Text(album.name)
                        .foregroundColor(Color("White"))
                        .font(.title)
                Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundColor(Color("White"))
                    
                }
                
                ScrollView{
                    ForEach(album.tracklist.songs) {song in
                        HStack(alignment: .top) {
                            Text("\(song.trackNumber).").foregroundColor(Color("White"))
                            Text(song.name).foregroundColor(Color("White"))
                            Spacer()
                            
                        }.padding(.vertical, 0.02)
                    }
                }                .frame(height: 250)
                
                HStack {
                    Text(album.artist).font(.title2).foregroundColor(Color("White"))
                    Spacer()
                    
                    Link(destination: URL(string: "https://open.spotify.com/album/\(album.spotifyUri)")!) {
                        Image("spotifyIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                }
                
            }.padding(.horizontal)
        }
    }
}

struct AlbumModalView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumModalComponent(album: Album.sampleData[1])
    }
}
