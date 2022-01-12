//
//  HomeView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var recentAlbums: [Album]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack{
                HeaderComponent()
                
                VStack {
                    NavigationLink(destination: AlbumARView(recentAlbums: $recentAlbums)){
                        VStack {
                            Image(systemName: "camera")
                                .font(.system(size: 24))
                                .frame(width: 56, height: 56)
                                .foregroundColor(Color("CustomYellow"))
                                .background(Color("CustomBlue"))
                                .clipShape(Circle())
                            Text("Start scanning")
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                BottomComponent(albums: recentAlbums)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(recentAlbums: .constant(Album.sampleData))
    }
}

