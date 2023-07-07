//
//  LikeButtonView.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 06/07/23.
//

import SwiftUI

struct LikeButtonView: View {
    @State private var likesCount = 0
    @State private var isLiked = false
    
    var body: some View {
        
        HStack {
            // thumbs up button
            Button(action: {
                if isLiked {
                    likesCount -= 1
                } else {
                    likesCount += 1
                }
                isLiked.toggle()
            }) {
                Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
            .foregroundColor(isLiked ? Color("customSecondary") : .gray)
            .frame(width: 18, height: 30)
            
            // likes count
            Text("\(likesCount)")
                .frame(width: 30, height: 30)
                .padding(.horizontal, -4)
            
        }
        
    }
}


struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView()
    }
}
