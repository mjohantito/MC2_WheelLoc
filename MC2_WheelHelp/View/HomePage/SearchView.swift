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
    @State private var categoryViews: [KategoriCardView] = []
    var notfound = false
    
    var body: some View {
        NavigationStack{
            
            ScrollView {
                
                //Scroll View List
                //                 VStack(alignment: .leading){
                //                     ForEach(0..<10, id: \.self){ _ in
                //                         CategoryListCardView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
                //                             .padding(.horizontal, 8)
                
                //                         if let imageURL = URL(string: "https://fastly.4sqi.net/img/general/100x10012259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg") {
                //                             CategoryListCardView(imageURL: imageURL, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "default", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                //                                 .padding(.horizontal, 8)
                //                         }
                
                
                VStack{
                    if(notfound == true){
                        Spacer()
                        Image("Empty State")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)
                        Text("Pencarian Tidak Ditemukan")
                            .font(.title2.bold())
                            .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                        Spacer()
                    }else{
                        ScrollView{
                            ForEach(categoryViews, id: \.placeName) { view in
                                view
                                    .padding(.horizontal, 8)
                            }
                            
                            
                        }
                        .onAppear {
                            fetchDataPlaceFromCloudKit(recordTypes: ["Place"], name: search) { views in
                                categoryViews = views
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                //Search Bar
                .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Cari Restoran & Cafe, Tempat Wisata, Hotel dan Pusat Belanja")
                .onChange(of: search) { search in
                    if !search.isEmpty{
                        fetchDataPlaceFromCloudKit(recordTypes: ["Place"], name: search) { views in
                            categoryViews = views
                            print("nama : \(search)")
                            print(views)
                        }
                        
                    } else {
                        fetchDataPlaceFromCloudKit(recordTypes: ["Place"], name: search) { views in
                            categoryViews = views
                            print("nama : \(search)")
                            print(views)
                        }
                        
                    }
                    
                }
                
            }
        }
    }
}
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }

