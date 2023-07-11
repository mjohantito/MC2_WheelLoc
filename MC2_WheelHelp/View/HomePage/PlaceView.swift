//
//  PlaceView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct PlaceView: View {
    @State private var search = ""
    @State private var categoryViews: [KategoriCardView] = []
    @EnvironmentObject var authManager: AuthManager
    
    @State private var userEmail: String = ""
    @State private var userId: String = ""
    
    @State private var activeTag: String = "Makan"
    
    var tags: [String] = [
        "Makan", "Wisata", "Hotel", "Belanja"
    ]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 15){
                HStack{
                    Text("Telusuri")
                        .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                        .font(.largeTitle.bold())
                        .padding(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .padding(.trailing)
                }
                .padding(.top)
                
                //Search Bar
                NavigationLink(destination: SearchView()){
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Cari Restoran & Cafe, Tempat Wisata, Hotel dan Tempat Belanja")
                        Spacer()
                    }
//<<<<<<< HEAD
//                    .padding(.top)
//                    .padding(.horizontal, 8)
//
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            //                            ForEach (0..<3, id: \.self){_ in
//                            //                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
//                            //                                    .padding(.horizontal, 8)
//                            //                            }
//                            ForEach(categoryViews, id: \.placeName) { view in
//                                view
//                                    .padding()
//                            }
//                        }
//                        .onAppear {
//                            fetchDataPlaceRecommendationFromCloudKit(recordTypes: ["Place"], category: "Restoran & Cafe") { views in
//                                categoryViews = views
//                            }
//                        }
//                    }
//
//                    //Restoran & Cafe
//                    HStack{
//                        Text("Tempat Wisata")
//                            .font(.title)
//                            .bold()
//
//                        Spacer()
//
//                        NavigationLink(destination: CategoryListView(kategori: "Tempat Wisata")) {
//                            Text("Lihat Semua")
//                                .foregroundColor(Color.blue)
//                        }
//                    }
//                    .padding(.top)
//                    .padding(.horizontal, 8)
//
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            ForEach (0..<3, id: \.self){_ in
//                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
//                                    .padding(.horizontal, 8)
//                            }
//                        }
//                    }
//
//                    //Hotel
//                    HStack{
//                        Text("Hotel")
//                            .font(.title)
//                            .bold()
//
//                        Spacer()
//
//                        NavigationLink(destination: CategoryListView(kategori: "Hotel")) {
//                            Text("Lihat Semua")
//                                .foregroundColor(Color.blue)
//                        }
//                    }
//                    .padding(.top)
//                    .padding(.horizontal, 8)
//
//                    ScrollView(.horizontal, showsIndicators: false){
//                        HStack{
//                            ForEach (0..<3, id: \.self){_ in
//                                KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
//                                    .padding(.horizontal, 8)
//                            }
//                        }
//                    }
//
//                    //Pusat Belanja
//                    Group {
//                        HStack{
//                            Text("Pusat Belanja")
//                                .font(.title)
//                                .bold()
//
//                            Spacer()
//
//                            NavigationLink(destination: CategoryListView(kategori: "Pusat Belanja")) {
//                                Text("Lihat Semua")
//                                    .foregroundColor(Color.blue)
//                            }
//                        }
//                        .padding(.top)
//                        .padding(.horizontal, 8)
//
//                        ScrollView(.horizontal, showsIndicators: false){
//                            HStack{
//                                ForEach (0..<3, id: \.self){_ in
//                                    KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
//                                        .padding(.horizontal, 8)
//                                }
//                            }
//=======
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.quaternary)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                }
                TagsView()
                
                ScrollView{
                    VStack{
                        ForEach (0..<3, id: \.self){_ in
                            KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Bebek Tepi Sawah", address: "Somewhere over the rainbow", kategori: activeTag, rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                            
                                .padding(.horizontal, 8)

                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.1))
        }
    }
    
    //TagView
    @ViewBuilder
    func TagsView() -> some View {
        HStack (){
            ForEach(tags, id: \.self) { tag in
                VStack{
                    Image(tag)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .padding(.top, 5)
                        
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 22)
                        .padding(.bottom, 5)
                }
                
//<<<<<<< HEAD
//            }
//            .navigationTitle("Telusuri")
//            .toolbar {
//                ToolbarItemGroup(placement: .primaryAction){
//                    NavigationLink(destination: SignInView(onSuccess: { email in }, userEmail: $userEmail, userId: $userId).environmentObject(authManager)) {
//
//                        Image(systemName: "person.circle")
//                            .resizable()
//                            .foregroundColor(.primary)
//                            .scaledToFit()
//                            .frame(width: 40, height: 40)
//
//=======
                //Active
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                        activeTag = tag

                    }
                }
                .background( content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.bar)
                })
                .font(Font.headline.weight(activeTag == tag ? .bold : .light))
                .opacity(activeTag == tag ? 1 : 0.3)
                .contentShape(Rectangle())
                .padding(.horizontal, 2)
            }
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
        }}
    
    struct PlaceView_Previews: PreviewProvider {
        static var previews: some View {
            PlaceView()
        }

    }
}
