//
//  CenterView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

struct CenterView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: AlbumARView()){
                Image(systemName: "camera")
                    .font(.system(size: 24))
                    .frame(width: 56, height: 56)
                    .foregroundColor(Color("CustomYellow"))
                    .background(Color("CustomBlue"))
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
            .padding()
            
            NavigationLink(destination: AlbumARView()){
                Text("Start scanning")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}


struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            CenterView()
        }
    }
}
