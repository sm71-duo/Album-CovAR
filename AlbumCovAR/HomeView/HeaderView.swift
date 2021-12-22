//
//  Header.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            Text("Album covAR")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title)
                .multilineTextAlignment(.center)
            
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            Text("Welcome Back!")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .font(.title2)
                .multilineTextAlignment(.center)
                
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
        
        Color("BackgroundColor").ignoresSafeArea()
        HeaderView()
        }
    }
}
