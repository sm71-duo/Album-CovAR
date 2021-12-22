//
//  HomeView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct HomeView: View {
    
    let recentAlbums: [Album] = [
        Album(name: "Flower Boy", artist: "Tyler, the Creator", coverImageName: "FlowerBoyAlbum"),
        Album(name: "Sand", artist: "Balthazar", coverImageName: "SandAlbum"),
        Album(name: "Skin", artist: "Flume", coverImageName: "SkinAlbum")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                VStack{
                    HeaderView()
                    
                    CenterView()
                    
                    Spacer()
                    
                    BottomView(albums: recentAlbums)
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

