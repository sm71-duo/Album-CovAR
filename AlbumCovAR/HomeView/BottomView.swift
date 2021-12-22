//
//  BottomView.swift
//  AlbumCovAR
//
//  Created by Quan on 22/12/2021.
//

import SwiftUI

let GradientBorder = LinearGradient(gradient: Gradient(colors: [Color("CustomBlue"), Color("CustomLightBlue").opacity(0.0)]), startPoint: .top, endPoint: .bottom)

struct BottomView: View {
    var body: some View {
        VStack{
            HStack() {
                Text("Recent Albums")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(.horizontal)
                Spacer()
            }
            
            
        }
        .padding(.vertical)
        .frame(minWidth: 0, maxWidth: .infinity)
        .overlay(
               RoundedRectangle(cornerRadius: 24)
                   .stroke(GradientBorder, lineWidth: 4))
        .padding()

        
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
        BottomView()
        }
    }
}
