//
//  KategoriCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct KategoriCardView: View {
    let image: String
    let title: String
    let rating: Double
    let jumlahrating: Int
    
    var body: some View {
        NavigationLink(destination: PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))) {
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
                        .stroke(.gray, lineWidth: 1)
            )
            }
        }
    }
}

struct KategoriCardView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
    }
}
