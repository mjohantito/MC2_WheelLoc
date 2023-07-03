//
//  CategoryListCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct CategoryListCardView: View {
    let image: String
    let title: String
    let subtitle: String
    let jam: String
    let kategori: String
    let rating: Double
    let jumlahUlasan: Int
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading){
                    //Nama Tempat
                    Text(title)
                        .font(.title)
                        .bold()
                    
                    //Alamat
                    Text(subtitle)
                        .font(.caption)
                    
                    //Jam Buka
                    Text("Buka \(jam)")
                        .font(.caption)
                    
                    //Kategori
                    Text(kategori)
                        .font(.caption)
                    
                    //Rating
                    HStack{
                        Image("wheelchair")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        StarRatingView(rating: .constant(Int(rating)))
                        
                        Text(String(rating))
                        
                        Text("(\(jumlahUlasan))")
                    }
                }
                
                //Gambar Resto
                Image(image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                
            }
            Divider()
        }
    }
}

struct CategoryListCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", subtitle: "Jalan Diponegoro No.87, Surabaya", jam: "07.00 - 20.00", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5)
    }
}

