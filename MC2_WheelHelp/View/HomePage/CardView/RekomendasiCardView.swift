//
//  RekomendasiCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct RekomendasiCardView: View {
    
    let image: String
    let title: String
    let rating: Double
    
    var body: some View {
//        NavigationLink(destination: PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))) {
            
            
            //        NavigationLink(destination: PlaceDetailInformationView()) {
            
            //NavigationLink(destination: PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [])) {
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
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    //Rating
                    Image("wheelchair")
                        .resizable()
                        .frame(width: 23, height: 23)
                    Text("\(String(rating))")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                }
            }
            //        }
        }
//    }
    
    struct RekomendasiCardView_Previews: PreviewProvider {
        static var previews: some View {
            RekomendasiCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5)
        }
    }
}
