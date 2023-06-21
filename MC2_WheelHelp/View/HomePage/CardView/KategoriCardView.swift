//
//  KategoriCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct KategoriCardView: View {
    let image: String
    let title: String
    let rating: Int
    let jumlahrating: Int
    
    var body: some View {
        VStack(alignment: .leading){
            //Gambar Tempat
            Image(image)
                .resizable()
                .frame(width: 170, height: 130)
                .cornerRadius(10, corners: [.topLeft, .topRight])
            
            //Nama Tempat
            Text(title)
                .font(.subheadline)
                .bold()
                .padding(.leading, 8)
            
            //Rating
            HStack{
                Image("wheelchair")
                    .resizable()
                    .frame(width: 23, height: 23)
                Text("\(String(rating)).0")
                    .font(.body)
                
                Spacer()
                
                Text("(\(String(jumlahrating)))")
            }
            .padding(.horizontal, 8)
            .padding(.bottom,8)
        }
        .frame(width: 170)
        .padding(.bottom, 4)
        
        //Corner Radius Card dan Border
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
    }
}

struct KategoriCardView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
    }
}
