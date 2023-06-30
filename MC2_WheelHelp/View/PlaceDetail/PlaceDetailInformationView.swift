//
//  PlaceDetailInformationView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 21/06/23.
//

import SwiftUI

struct PlaceDetailInformationView: View {
    
    @State var showSheet = false
    
    var body: some View {
        NavigationStack{
            ScrollView{
                
                TabView {
                    
                    Image("national-hospital")
                        .resizable()
                        .frame(maxWidth: .infinity)
                    
                    Image("national-hospital")
                        .resizable()
                        .frame(maxWidth: .infinity)
                    
                    Image("national-hospital")
                        .resizable()
                        .frame(maxWidth: .infinity)
                }
                .frame(height: 300)
                .tabViewStyle(.page)
                .padding(.top, -80)
                
                VStack{
                    
                    // Section Image Slider
                    
                    
                    
                    
                    // Section Nama Tempat & Rating
                    
                    VStack{
                        Text("Pakuwon Mall")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top,10)

                    }
                    HStack {
                        Image("wheelchairSmall")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(Color.yellow)
                        ForEach (1..<6) { _ in
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        }
        
                        Text("5.0")
                            .fontWeight(.bold)
                        
                        Text("(4)")
                        Spacer()
                    }
                    .frame(alignment: .leading)
                    .padding(.bottom, 20)
                    
                    // End Section Nama Tempat & Rating
                    
                    Divider()
                    
                    //Section Fasilitas
                    
                    VStack{
                        HStack{
                            Text("Fasilitas")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.bold)
                            
                                NavigationLink(destination: PlaceDetailFacilityView()){
                                    Text("Lihat Semua")
                                }
                            
                        }
                        HStack{
                            VStack(alignment: .leading){
                                
                                HStack {
                                    Image("elevator")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    Text("Lift")
                                }
                                
                                HStack {
                                    Image("escalator")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    
                                    Text("Eskalator")
                                }
                                
                                HStack {
                                    Image("ramp-loading")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    
                                    Text("Ramp")
                                }
                                
                                
                            }.padding(.top,8)
                            
                            Spacer()
                            VStack(alignment: .leading){
                                HStack {
                                    Image("wheelchairSmall")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    Text("Toilet Disabilitas")
                                }
                                
                                HStack {
                                    Image("wheelchairSmall")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    Text("Akses Masuk")
                                }
                                
                                HStack {
                                    Image("wheelchairSmall")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .leading)
                                    .foregroundColor(Color.black)
                                    
                                    Text("Tempat Parkir")
                                }
                                
                                
                            }
                            
                            
                            
                            
                        }
                        
                    }
                    
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    
                    // End Section Fasilitas
                    
                    Divider()
                    
                    // Section Fasilitas Kesehatan Terdekat
                    
                    VStack {
                        HStack{
                            Text("Fasilitas Kesehatan Terdekat")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.bold)
                        }
                        
                        // Slider Nearby Fasilitas Kesehatan
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                
                                ForEach (0..<3, id: \.self){_ in
                                    NearbyHealthFacilitiesCardView(imageNearbyFacilites: "national-hospital", titleNearbyFacilities: "National Hospital", categoryNearbyFacilities: "Rumah Sakit", distanceNearbyFacilities: 4.5)
                                }

                                Spacer()
                                
                            }
                            .frame(alignment: .leading)
                            
                            
                        }
                        
                    }
                    .padding(.top,8)
                    .padding(.bottom,8)
                    
                    Divider()
                    
                    // End Section Fasilitas Kesehatan Terdekat
                    
                }
                .padding()
                
                // Section Ulasan
                
                VStack{
                    HStack{
                        Text("Ulasan")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                        NavigationLink(destination: PlaceDetailReviewView()){
                            Text("Lihat Semua")
                        }
                    }
                    
                    // Slider Top 3 Ulasan
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            
                            ForEach (0..<3, id: \.self){_ in
                                ReviewSmallCardView(userNameReview: "Angelo Kusuma", dateReview: "30 Mar 2023", ratingReview: 4.5, titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
                            }

                            Spacer()
                            
                        }
                        .frame(alignment: .leading)
                        
                    }
                    
                    // Button Tulis Ulasan
                    
                    HStack {
                        Button{
                            showSheet.toggle()
                        }label: {
                            Text(Image(systemName: "square.and.pencil"))
                                .padding(.top)
                            Text("Tulis Ulasan")
                                .frame(alignment: .leading)
                                .padding(.top)
                            
                                .sheet(isPresented: $showSheet){
                                    AddReviewView(rating: 3, maxRating: 5)
                                }
                    }
                        
                        Spacer()
                    }
                    
                    
                    
                }
                .padding()
                
                Divider()
                
                // End Ulasan
                
                
                // Section Lokasi
                
                VStack{
                    HStack{
                        Text("Lokasi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                        
                    }

             
                    Button(action: {
                        if let url = URL(string: "https://maps.apple.com/?ll=-7.28879,112.675712") {
                                    UIApplication.shared.open(url)
                                }
                            }) {
                                Image("appleMapsStatic")
                                    .resizable()
                                    .scaledToFill()
                            }

                    
                }
                .padding()
            
                
                
                
                
            }
            


        }.ignoresSafeArea()
    }
}

struct PlaceDetailInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailInformationView()
    }
}
