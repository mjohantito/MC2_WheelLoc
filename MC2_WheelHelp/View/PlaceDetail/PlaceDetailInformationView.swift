//
//  PlaceDetailInformationView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 21/06/23.
//

import SwiftUI
import MapKit
import CloudKit

struct PlaceDetailInformationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var authManager: AuthManager
    @State private var isUserSignedIn = false
    @State private var showSignInSheet = false
    @State private var showAddReviewSheet = false
    @State private var userEmail: String = ""
    @State private var userId: String = ""
    @State var showSheet = false
    
    @State private var placeDetailInformationView: [PlaceDetailInformationView] = []
    @State private var categoryViews: [NearbyHealthFacilitiesCardView] = []
    
    @State private var imageURLs: [URL] = []
    @State public var placeName: String
    @State private var address: String
    @State private var kategori: String
    @State private var rating: Double
    @State private var jumlahUlasan: Int
    @State private var fsq_id: String
    @State private var latitude: Double
    @State private var longitude: Double
    @State private var health_facilities_id: [String]
    @State var ckRecordIdPlace: CKRecord.ID?
    
    //    let latitudeRegion: Double
    //    let longitudeRegion: Double
    
    //
    //    @State var spot: Spot
    //    @State private var mapRegion = MKCoordinateRegion()
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -7.285406, longitude: 112.631832), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    
    init(imageURLs: [URL], placeName: String, address: String, kategori: String, rating: Double, jumlahUlasan: Int, fsq_id:String, latitude:Double, longitude: Double, health_facilities_id: [String], ckRecordIdPlace: CKRecord.ID) {
        self._imageURLs = State(initialValue: imageURLs)
        self._placeName = State(initialValue: placeName)
        self._address = State(initialValue: address)
        self._kategori = State(initialValue: kategori)
        self._rating = State(initialValue: rating)
        self._jumlahUlasan = State(initialValue: jumlahUlasan)
        self._fsq_id = State(initialValue: fsq_id)
        self._latitude = State(initialValue: latitude)
        self._longitude = State(initialValue: longitude)
        self._health_facilities_id = State(initialValue: health_facilities_id)
        self._ckRecordIdPlace = State(initialValue: ckRecordIdPlace)
    }
    
    
    
    var body: some View {
        NavigationView{
            ScrollView {
                ZStack (alignment: .leading){
                    
                    if imageURLs.isEmpty {
                        Image("national-hospital")
                            .resizable()
                            .frame(maxWidth: .infinity)
                    } else {
                        TabView {
                            ForEach(imageURLs.indices, id: \.self) { index in
                                AsyncImage(url: imageURLs[index]) { image in
                                    image
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                } placeholder: {
                                    Image("BebekTepiSawah")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .frame(height: 300)
                        .tabViewStyle(PageTabViewStyle())
                        .padding(.top, -80)
                    }
                    
                    
                    
                    
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
                    VStack{
                        
                        // Section Image Slider
                        
                        
                        
                        
                        // Section Nama Tempat & Rating
                        VStack{
                            Text(placeName)
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
                            ForEach(1..<6) { index in
                                if index <= Int(rating) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.orange)
                                        .frame(width: 14, height: 22, alignment: .leading)
                                } else if index - 1 == Int(rating) && rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
                                    Image(systemName: "star.leadinghalf.filled")
                                        .foregroundColor(Color.orange)
                                        .frame(width: 14, height: 22, alignment: .leading)
                                } else {
                                    Image(systemName: "star")
                                        .foregroundColor(Color.orange)
                                        .frame(width: 14, height: 22, alignment: .leading)
                                }
                            }
                            
                            Text("\(rating, specifier: "%.1f")")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                                .foregroundColor(Color.orange)
                                .padding(.leading, 5)
                            
                            Text("(\(jumlahUlasan))")
                                .foregroundColor(Color.gray)
                            Spacer()
                        }
                        .frame(alignment: .leading)
                        .padding()
                        
                        // End Section Nama Tempat & Rating
                        
                        Divider()
                            .padding(.leading, 8)
                            .padding(.trailing, 8)
                        
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
                                    
                                    HStack {
                                        Image("wheelchairSmall")
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
                        
                        
                        // End Section Fasilitas
                        
                        
                        
                        
                        
                        // End Section Fasilitas Kesehatan Terdekat
                        
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    
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
                                ForEach(categoryViews.indices, id: \.self) { index in
                                    NearbyHealthFacilitiesCardView(imageURL: categoryViews[index].imageURL,
                                                                   placeName: categoryViews[index].placeName,
                                                                   address: categoryViews[index].address,
                                                                   kategori: categoryViews[index].kategori,
                                                                   fsq_id: categoryViews[index].fsq_id,
                                                                   latitude: categoryViews[index].latitude,
                                                                   longitude: categoryViews[index].longitude)
                                }
                                Spacer()
                            }
                            .frame(alignment: .leading)
                            .onAppear {
                                fetchDataHealthFacilityFromCloudKit(recordTypes: ["HealthFacility"], fsqIDs: health_facilities_id) { views in
                                    categoryViews = views
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // Section Ulasan
                    
                    VStack{
                        HStack{
                            Text("Ulasan")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .fontWeight(.bold)
                            //                        let a = print(ckRecordIdPlace?.recordName)
                            NavigationLink(destination: PlaceDetailReviewView(placeId: ckRecordIdPlace ?? CKRecord.ID(recordName: ""))){
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
                                if authManager.isSignedIn {
                                    showAddReviewSheet.toggle()
                                } else {
                                    showSignInSheet = true
                                }
                            }label: {
                                Text(Image(systemName: "square.and.pencil"))
                                    .padding(.top)
                                Text("Tulis Ulasan")
                                    .frame(alignment: .leading)
                                    .padding(.top)
                                
                                
                            }
                            .sheet(isPresented: $showAddReviewSheet) {
                                
                                AddReviewView(rating: 3, maxRating: 5, fsq_id: fsq_id, ckRecordIdPlace: ckRecordIdPlace!, placeName: placeName, userEmail: $userEmail)
                            }
                            .sheet(isPresented: $showSignInSheet) {
                                SignInView(onSuccess: { email in
                                    // Handle successful sign-in by showing AddReviewView
                                    showSignInSheet = false
                                    showAddReviewSheet = true
                                    userEmail = email
                                    userId = userId
                                    print("Parent view: \(userEmail)")
                                }, userEmail: $userEmail, userId: $userId)
                                .environmentObject(authManager) // Pass the authManager to SignInView
                                //                            SignInView(onSuccess: {
                                //                                // Handle successful sign-in by showing AddReviewView
                                //                                showSignInSheet = false
                                //                                showAddReviewSheet = true
                                //                            },appleUserId: "default", appleUserFName: "default", appleUserLName: "default")
                                ////                            SignInView(appleUserId: "default", appleUserFName: "default", appleUserLName: "default")
                                ////                                .environmentObject(authManager)
                                ////                            showSignInSheet = false
                                ////                            showAddReviewSheet = true
                                ////                            .environmentObject(authManager) // Pass the authManager to SignInView
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 8)
                        .padding(.bottom, 20)
                        
                        
                        
                    }
                    .padding(.top, 8)
                    .background(Color.white)
                    .cornerRadius(20)
                    
                    
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
                            
                            
                            // add maps here
                            Map(coordinateRegion: $mapRegion, showsUserLocation: true)
                                .scaledToFill()
                                .onTapGesture {
                                    openMaps()
                                }
                            
                            // kasi padding
                            
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
        .onAppear {
            //            latitudeRegion == latitude
            //            longitudeRegion == longitude
            
            mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters:500 ,longitudinalMeters: 500)
            print("longitude ,\(longitude)")
            print("latitude ,\(latitude)")
            
            fetchDataFromCloudKit(fsq_id: fsq_id) { views in
                placeDetailInformationView = views
            }
        }
        
    }
    private func openMaps() {
        //            let latitudeString = String(latitude)
        //            let longitudeString = String(longitude)
        //
        //            if let url = URL(string: "http://maps.apple.com/?ll=\(latitudeString),\(longitudeString)") {
        //                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        //            }
        let encodedPlaceName = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "http://maps.apple.com/?daddr=\(latitude),\(longitude)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}



struct PlaceDetailInformationView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
    }
}
