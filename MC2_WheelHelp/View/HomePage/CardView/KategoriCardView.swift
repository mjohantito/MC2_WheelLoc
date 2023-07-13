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
    
    @State private var imageURLs: [URL]
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
    
    init(imageURLs: [URL], placeName: String, address: String, kategori: String, rating: Double, jumlahUlasan: Int, fsq_id:String, latitude:Double, longitude: Double, health_facilities_id: [String], ckRecordIdPlace: CKRecord.ID) {
        self._imageURLs = State(initialValue: imageURLs)
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
        NavigationLink(destination: PlaceDetailInformationView(imageURLs: imageURLs, placeName: placeName, address: address, kategori:category, rating: rating, jumlahUlasan: jumlahUlasan, fsq_id: fsq_id, latitude: latitude, longitude: longitude, health_facilities_id: health_facilities_id, ckRecordIdPlace: ckRecordIdPlace)) {

            VStack {
                HStack{
                    //Gambar Resto
                    AsyncImage(url: imageURLs.first) { image in
                        let a = print("image nih \(imageURLs.first)")
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                    } placeholder: {
                        // Placeholder image or activity indicator
                        Image("BebekTepiSawah")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                    }
                    
                    VStack(alignment: .leading){
                        //Nama Tempat
                        Text(placeName)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                            .multilineTextAlignment(.leading)
                        
                        //Kategori
                        Text(category)
                            .font(.caption)
                            .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                            .multilineTextAlignment(.leading)
                        
                        //Alamat
                        Text(address)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.leading)
                            .padding(.top, -3)

                        
                        
                        //Rating
                        HStack{
                            Image("wheelchairSmall")
                                .resizable()
                                .frame(width: 22, height: 22)
                                .foregroundColor(Color.orange)
                            
                            Text(String(rating))
                                .foregroundColor(.orange)
                                .bold()
                            
                            
                            Text("(\(jumlahUlasan))")
                                .foregroundColor(.secondary)
                        }
                    }
                    Spacer()
                }
            }

//        }

            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(content:{
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            })
            .padding(.top, 10)
        }

//        }
    }
}

struct KategoriCardView_Previews: PreviewProvider {
    static var previews: some View {
        KategoriCardView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
    }
}
