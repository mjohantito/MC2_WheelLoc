//
//  SearchView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 22/06/23.
//

import SwiftUI
import CloudKit

struct SearchView: View {
    @State private var search = ""
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                //Scroll View List
                VStack(alignment: .leading){
                    ForEach(0..<10, id: \.self){ _ in
                        CategoryListCardView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
                            .padding(.horizontal, 8)

//                         if let imageURL = URL(string: "https://fastly.4sqi.net/img/general/100x10012259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg") {
//                             CategoryListCardView(imageURL: imageURL, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "default", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
//                                 .padding(.horizontal, 8)
//                         }

                    }
                }
                
            }
//            .navigationTitle("Restoran dan Cafe")
            //Search Bar
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
        }
        
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
