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
                VStack{
                    HeaderView()
                    
                    
                    CenterView()
                    
                    Spacer()
                    
                    BottomView()                    
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

