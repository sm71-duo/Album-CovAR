//
//  AlbumModalView.swift
//  AlbumCovAR
//
//  Created by Quan on 23/12/2021.
//

import SwiftUI

struct AlbumModalComponent: View {
    
    @ObservedObject var albumStoreState: AlbumStore
    
    let uiscreen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            ZStack {
                AsyncImage(url: URL(string: albumStoreState.album.image.last?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color("Black")
                }
                
                Rectangle().fill(LinearGradient(gradient: Gradient(colors: [albumStoreState.album.avgColor, albumStoreState.album.avgColor.opacity(0.0)]), startPoint: .init(x: 0.4, y: 0.4), endPoint: .trailing))
            }
            .frame(width: self.uiscreen.width,
                   height: self.uiscreen.width,
                   alignment: .center)
            VStack(alignment: .leading) {
                HStack{
                    Text(albumStoreState.album.name)
                        .font(.title)
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                    
                }
                
                ScrollView{
                    ForEach(albumStoreState.album.tracks) {song in
                        HStack(alignment: .top) {
                            Text("\(song.rank).")
                            Text(song.name)
                            Spacer()
                            
                        }.padding(.vertical, 0.02)
                    }
                }                .frame(height: 250)
                
                HStack {
                    Text(albumStoreState.album.artist)
                        .font(.title2)
                    Spacer()
                    
                    Link(destination: URL(string: "https://open.spotify.com/album/\(albumStoreState.album.url)")!) {
                        Image("spotifyIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    
                }
                
            }.padding(.horizontal)
                .foregroundColor(albumStoreState.album.contrastColor)
        }
    }
}

//struct AlbumModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumModalComponent(album: Album.sampleData[5])
//    }
//}
