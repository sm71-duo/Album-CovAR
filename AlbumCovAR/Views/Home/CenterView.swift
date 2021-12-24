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
           
                Text("Start scanning")
                    .foregroundColor(.white)
                    .font(.headline)
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
