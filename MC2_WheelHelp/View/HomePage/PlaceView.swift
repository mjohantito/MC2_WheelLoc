//
//  PlaceView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct PlaceView: View {
    @State private var search = ""
    
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
                            ForEach (0..<3, id: \.self){_ in
                                KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
                                    .padding(.horizontal, 8)
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
                                KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
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
                                KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
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
                                    KategoriCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", rating: 5, jumlahrating: 5)
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
//                    NavigationLink(destination: SignInView(onSuccess: { email in }, userEmail: "")) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .foregroundColor(.primary)
                            .scaledToFit()
                            .frame(width: 40, height: 40)
//                    }
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
