//
//  CategoryListCardView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct CategoryListCardView: View {
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
    var authManager = AuthManager()
    
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
        
        NavigationLink(destination: PlaceDetailInformationView(imageURLs: [imageURL], placeName: placeName, address: address, kategori:category, rating: rating, jumlahUlasan: jumlahUlasan, fsq_id: fsq_id, latitude: latitude, longitude: longitude, health_facilities_id: health_facilities_id, ckRecordIdPlace: ckRecordIdPlace)) {
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        //Nama Tempat
                        Text(placeName)
                            .font(.title2)
                            .bold()
                            .foregroundColor(Color("customBlack"))
                            .multilineTextAlignment(.leading)
                        
                        //Alamat
                        Text(address)
                            .font(.caption)
                            .foregroundColor(Color("customBlack"))
                            .multilineTextAlignment(.leading)

                        //Kategori
                        Text(category)
                            .font(.caption)
                            .foregroundColor(Color("customBlack"))
                            .multilineTextAlignment(.leading)
                        
                        //Rating
                        HStack{
                            Image("wheelchairSmall")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("customBlack"))
                            
                            StarRatingView(rating: .constant(Int(rating)))
                            
                            Text(String(rating))
                                .foregroundColor(Color("customBlack"))
                            
                            Text("(\(jumlahUlasan))")
                                .foregroundColor(Color("customBlack"))
                        }
                    }
                    //Gambar Resto
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    } placeholder: {
                        // Placeholder image or activity indicator
                        Image("BebekTepiSawah")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    }
                    
                    
                }
                Divider()
            }
            .onAppear {
                print("longitude,\(longitude)")
                print("latitude, \(latitude)")
            }
            
            

            .environmentObject(authManager)
        }
        
        
    }
        
}

struct CategoryListCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
    }
}
