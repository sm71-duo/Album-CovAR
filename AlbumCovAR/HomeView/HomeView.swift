//
//  HomeView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                
                VStack {
                    Text("Album covAR").fontWeight(.bold).foregroundColor(.white).font(.system(size: 32))
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250.0, height: 250.0)
                        .padding()
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).foregroundColor(.white)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

