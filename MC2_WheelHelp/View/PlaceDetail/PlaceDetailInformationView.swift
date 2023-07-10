//
//  PlaceDetailInformationView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 21/06/23.
//

import SwiftUI

struct PlaceDetailInformationView: View {
    
    @State var showSheet = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ZStack (alignment: .leading){
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

                    
                    VStack {
                        Button(){
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.primary)
                        }
                        .padding(.leading)
                           
                        Spacer()
                    }
                    
                }
                
                VStack{
                    
                    // Section Nama Tempat & Rating
                    VStack{
                        VStack{
                            Text("Pakuwon Mall")
                                .font(.system(size:24))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .padding(.bottom,-20)
                            
                        }
                        HStack {
                            Image("wheelchairSmall")
                                .resizable()
                                .frame(width: 22, height: 22, alignment: .leading)
                                .foregroundColor(Color.orange)
                            ForEach (1..<6) { _ in
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.orange)
                                    .frame(width: 14, height: 22, alignment: .leading)
                            }
                            
                            Text("5.0")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.orange)
                                .padding(.leading,5)
                            
                            Text("(4)")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .frame(alignment: .leading)
                        .padding()
                        
                        // End Section Nama Tempat & Rating
                        
                        Divider()
                            .padding(.leading,8)
                            .padding(.trailing,8)
                        
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
                                        Image("icon_lift")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        Text("Lift")
                                    }
                                    
                                    HStack {
                                        Image("icon_escalator")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        Text("Eskalator")
                                    }
                                    
                                    HStack {
                                        Image("icon_ramp")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        Text("Ramp")
                                    }
                                    
                                    HStack {
                                        Image("icon_wheelchair")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        Text("Tersedia Kursi Roda")
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
                                        Image("icon_entrance")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        Text("Akses Masuk")
                                    }
                                    
                                    HStack {
                                        Image("icon_parkinglot")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        Text("Tempat Parkir")
                                    }
                                    
                                    HStack {
                                        Image("")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.black)
                                        
                                        Text("")
                                    }
                                    
                                    
                                }
                                
                                
                                
                                
                            }
                            
                        }
                        
                        .padding()
                        
                        
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    
                    // End Section Fasilitas
                    
                    
                   
                    
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
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                   
                    
                    // End Section Fasilitas Kesehatan Terdekat
                    
                
                
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
                        .padding()
                        
                        // Slider Top 3 Ulasan
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                
                                ForEach (0..<3, id: \.self){_ in
                                    ReviewSmallCardView(userNameReview: "Angelo Kusuma", dateReview: "30 Mar 2023", ratingReview: 4.5, titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!")
                                }
                                
                                Spacer()
                                
                            }
                            .frame(alignment: .leading)
                            .padding(.leading, 8)
                            
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
                        }.padding(.leading, 8)
                            .padding(.bottom, 20)
                        
                        
                        
                        
                    }
                    .padding(.top,8)
                    .background(Color.white)
                    
                    .cornerRadius(10)
//                    }
//                .padding()
                    
                
            
                // End Ulasan
                
                
                // Section Lokasi
                
                VStack{
                    HStack{
                        Text("Lokasi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fontWeight(.bold)
                        
                    }
                        .padding(.top, 8)
                    
                    
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
                .background(Color.white)
                
                .cornerRadius(10)
                
                    
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
        }
        .navigationBarHidden(true)
        
    }
}

struct PlaceDetailInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailInformationView()
    }
}
