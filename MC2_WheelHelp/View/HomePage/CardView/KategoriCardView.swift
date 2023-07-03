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
    let rating: Double
    let jumlahrating: Int
    
    var body: some View {
//        NavigationLink(destination: PlaceDetailInformationView(imageURL: URL(string: "default") ?? , placeName: "default", address: "default", kategori:"default", rating: 1.0, jumlahUlasan: 1, fsq_id: "default", latitude: 1.0, longitude: 1.0)) {
            HStack {
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
                        .foregroundColor(.primary)
                    
                    //Rating
                    HStack{
                        Image("wheelchair")
                            .resizable()
                            .frame(width: 23, height: 23)
                        Text("\(String(rating))")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Text("(\(String(jumlahrating)))")
                            .foregroundColor(.primary)
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
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
            )
            }
        }
    }
//}

struct KategoriCardView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
    }
}
