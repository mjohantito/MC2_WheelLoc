//
//  KategoriCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct KategoriCardView: View {
//    let image: String
//    let title: String
//    let rating: Double
//    let jumlahrating: Int
    
    @State private var imageURL: URL
    @State public var placeName: String
    @State private var address: String
    //    let jam: String
    @State private var category: String
    @State private var rating: Double
    @State private var jumlahUlasan: Int
    @State private var fsq_id: String
    @State private var latitude: Double
    @State private var longitude: Double
    @State private var health_facilities_id: [String]
    @State private var ckRecordIdPlace: CKRecord.ID
    
    init(imageURL: URL, placeName: String, address: String, kategori: String, rating: Double, jumlahUlasan: Int, fsq_id:String, latitude:Double, longitude: Double, health_facilities_id: [String], ckRecordIdPlace: CKRecord.ID) {
        self._imageURL = State(initialValue: imageURL)
        self._placeName = State(initialValue: placeName)
        self._address = State(initialValue: address)
        self._category = State(initialValue: kategori)
        self._rating = State(initialValue: rating)
        self._jumlahUlasan = State(initialValue: jumlahUlasan)
        self._fsq_id = State(initialValue: fsq_id)
        self._latitude = State(initialValue: latitude)
        self._longitude = State(initialValue: longitude)
        self._health_facilities_id = State(initialValue: health_facilities_id)
        self._ckRecordIdPlace = State(initialValue: ckRecordIdPlace)
    }
    
    var body: some View {
        //NavigationLink(destination: PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))) {
        //        NavigationLink(destination: PlaceDetailInformationView()) {
//        NavigationLink(destination: PlaceDetailInformationView(imageURLs: [imageURL], placeName: placeName, address: address, kategori:category, rating: rating, jumlahUlasan: jumlahUlasan, fsq_id: fsq_id, latitude: latitude, longitude: longitude, health_facilities_id: health_facilities_id, ckRecordIdPlace: ckRecordIdPlace)) {

            HStack {
                VStack(alignment: .leading){
                    //Gambar Tempat
                    //                Image(imageURL[0])
                    //                    .resizable()
                    //                    .frame(width: 170, height: 130)
                    //                    .cornerRadius(10, corners: [.topLeft, .topRight])
                    
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 170, height: 130)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                    } placeholder: {
                        // Placeholder image or activity indicator
                        Image("BebekTepiSawah")
                            .resizable()
                            .frame(width: 170, height: 130)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                    }
                    
                    //Nama Tempat
                    Text(placeName)
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
                        
                        Text("(\(String(jumlahUlasan)))")
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
//        }
//        }
    }
}

struct KategoriCardView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
    }
}
