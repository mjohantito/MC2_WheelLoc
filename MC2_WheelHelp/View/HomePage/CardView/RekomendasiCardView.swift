//
//  RekomendasiCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct RekomendasiCardView: View {

    let image: String
    let title: String
    let rating: Int
   
    var body: some View {
        VStack{
            //Gambar Tempat
            Image(image)
                .resizable()
                .frame(width: 350, height: 200)
                .cornerRadius(10)
            
            HStack{
                //Nama Tempat
                Text(title)
                    .font(.title)
                    .bold()
                
                Spacer()
                
                //Rating
                Image("wheelchair")
                    .resizable()
                    .frame(width: 23, height: 23)
                Text("\(String(rating)).0")
                    .font(.body)
                
            }
        }
    }
}

struct RekomendasiCardView_Previews: PreviewProvider {
    static var previews: some View {
        RekomendasiCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5)
    }
}
