//
//  PlaceView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct PlaceView: View {
    @State private var search = ""
    @State private var categoryViews: [KategoriCardView] = []
    @EnvironmentObject var authManager: AuthManager
    
    @State private var userEmail: String = ""
    @State private var userId: String = ""
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    
                    //Rekomendasi
                    Text("REKOMENDASI")
                        .padding(.leading, 16)
                        .foregroundColor(Color.blue)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            ForEach(0..<2, id: \.self){ _ in
                                RekomendasiCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5)
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    Divider()
                    
                    //Restoran & Cafe
                    HStack{
                        Text("Restoran & Cafe")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: CategoryListView(kategori: "Restoran & Cafe")) {
                            Text("Lihat Semua")
                                .foregroundColor(Color.blue)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            //                            ForEach (0..<3, id: \.self){_ in
                            //                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                            //                                    .padding(.horizontal, 8)
                            //                            }
                            ForEach(categoryViews, id: \.placeName) { view in
                                view
                                    .padding()
                            }
                        }
                        .onAppear {
                            fetchDataPlaceRecommendationFromCloudKit(recordTypes: ["Place"], category: "Restoran & Cafe") { views in
                                categoryViews = views
                            }
                        }
                    }
                    
                    //Restoran & Cafe
                    HStack{
                        Text("Tempat Wisata")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: CategoryListView(kategori: "Tempat Wisata")) {
                            Text("Lihat Semua")
                                .foregroundColor(Color.blue)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach (0..<3, id: \.self){_ in
                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                    
                    //Hotel
                    HStack{
                        Text("Hotel")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink(destination: CategoryListView(kategori: "Hotel")) {
                            Text("Lihat Semua")
                                .foregroundColor(Color.blue)
                        }
                    }
                    .padding(.top)
                    .padding(.horizontal, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach (0..<3, id: \.self){_ in
                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                                    .padding(.horizontal, 8)
                            }
                        }
                    }
                    
                    //Pusat Belanja
                    Group {
                        HStack{
                            Text("Pusat Belanja")
                                .font(.title)
                                .bold()
                            
                            Spacer()
                            
                            NavigationLink(destination: CategoryListView(kategori: "Pusat Belanja")) {
                                Text("Lihat Semua")
                                    .foregroundColor(Color.blue)
                            }
                        }
                        .padding(.top)
                        .padding(.horizontal, 8)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach (0..<3, id: \.self){_ in
                                    KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                                        .padding(.horizontal, 8)
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Telusuri")
            .toolbar {
                ToolbarItemGroup(placement: .primaryAction){
                    NavigationLink(destination: SignInView(onSuccess: { email in }, userEmail: $userEmail, userId: $userId).environmentObject(authManager)) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .foregroundColor(.primary)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                }
            }
        }
        .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
    }}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView()
    }
}
