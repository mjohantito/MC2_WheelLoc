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
    @AppStorage("isSignedIn") private var isSignedIn = false
    @AppStorage("userIdGlobal") var userIdGlobal: String = ""
    @State private var showSignInSheet = false
    @State private var showAddReviewSheet = false
    @State private var userEmail: String = ""
    @State private var userId: String = ""
    @State var showSheet = false
    
//    @State private var placeDetailInformationView: [PlaceDetailInformationView] = []
//    @State private var categoryViews: [NearbyHealthFacilitiesCardView] = []
    @State private var categoryViews: [NearbyHealthFacilitiesCardView] = []
    @State private var reviewResponses: [ReviewResponse] = []
    @State private var mostLikedReviewResponse: ReviewResponse?
    @State public var isFacilitiesAvailable: FacilityFromReviewResponse?
    
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
    @State var ckRecordIdPlace: CKRecord.ID
    
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
                        Image(systemName: "photo")
                            .resizable()
                            .frame(maxWidth: .infinity)
                    } else {
                        TabView( content:  {
                            ForEach(imageURLs, id: \.self) { index in
                                AsyncImage(url: index) { image in
                                    image
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                } placeholder: {
                                    Color.gray
                                }
                            }
                        })
                        .padding(.top, -80)
                        .frame(height: 300)
                        .tabViewStyle(PageTabViewStyle())
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                        
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
                                
                                NavigationLink(destination: PlaceDetailFacilityView(dataFacilitiesResponse: $mostLikedReviewResponse)){
                                    Text("Lihat Semua")
                                }
                                
                            }
                            HStack{
                                VStack(alignment: .leading){

                                    HStack {
                                        if (isFacilitiesAvailable?.isLiftAvailable == true) {
                                            Image("elevator")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Lift")
                                        } else {
                                            Image("elevator")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Lift")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    HStack {
                                        if (isFacilitiesAvailable?.isEscalatorAvailable == true) {
                                            Image("escalator")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Eskalator")
                                        } else {
                                            Image("escalator")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Eskalator")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    HStack {
                                        if (isFacilitiesAvailable?.isRampAvailable == true) {
                                            Image("ramp-loading")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Ramp")
                                        } else {
                                            Image("ramp-loading")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Ramp")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    HStack {
                                        if (isFacilitiesAvailable?.isWheelchairAvailable == true) {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Tersedia Kursi Roda")
                                        } else {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Tersedia Kursi Roda")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    
                                }.padding(.top,8)
                                
                                Spacer()
                                VStack(alignment: .leading){
                                    HStack {
                                        if (isFacilitiesAvailable?.isToiletAvailable == true) {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Toilet Disabilitas")
                                        } else {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Toilet Disabilitas")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    HStack {
                                        if (isFacilitiesAvailable?.isEntranceAvailable == true) {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Akses Masuk")
                                        } else {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Akses Masuk")
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                    HStack {
                                        if (isFacilitiesAvailable?.isParkingAvailable == true) {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.black)
                                            Text("Tempat Parkit")
                                        } else {
                                            Image("wheelchairSmall")
                                                .resizable()
                                                .frame(width: 30, height: 30, alignment: .leading)
                                                .foregroundColor(Color.gray)
                                            Text("Tempat Parkir")
                                                .foregroundColor(Color.gray)
                                        }
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
                            NavigationLink(destination: PlaceDetailReviewView(reviewResponses: reviewResponses, placeId: ckRecordIdPlace)){
                                Text("Lihat Semua")
                            }
                        }
                        .padding()
                        
                        // Slider Top 3 Ulasan
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(reviewResponses.prefix(3), id: \.ckRecordIdReview) { response in
                                    ReviewSmallCardView(
                                        userFName: response.firstName,
                                        userLName: response.lastName,
                                        dateReview: response.date,
                                        titleReview: response.title,
                                        descriptionReview: response.description,
                                        likesReview: Int(response.likes),
                                        ratingReview: response.accessibilityRating,
                                        ckRecordIdReview: response.ckRecordIdReview,
                                        ckRecordIDPlace: response.placeId,
                                        isLiked: response.isLiked
                                    )
                                }
                                Spacer()
                            }
                            .frame(alignment: .leading)
                            .padding(.leading, 8)
                        }
                        
                        // Button Tulis Ulasan
                        
                        HStack {
                            Button{
                                if isSignedIn {
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
                            .sheet(isPresented: $showAddReviewSheet, onDismiss: {
                                print("called")
                                checkIfUserLikesReview(userId: userIdGlobal) { likedReviewIDs in

                                    fetchDataPlaceReviewFromCloudkit(recordTypes: ["Review"], placeId: ckRecordIdPlace, userId: userIdGlobal, likedReviewIDs: likedReviewIDs) { responses, likedResponses  in
                                        reviewResponses = responses ?? []
                                        print("review: \(reviewResponses.count)")
                                        mostLikedReviewResponse = likedResponses ?? nil
                                    }
                                    fetchDataFacilityFromMostLikedReview(reviewId: mostLikedReviewResponse?.ckRecordIdReview ?? CKRecord.ID(recordName: "default")) { dataFacilities in
                                        isFacilitiesAvailable = dataFacilities

                                    }

                                }
                            }) {
                                AddReviewView(rating: 3, maxRating: 5, fsq_id: fsq_id, ckRecordIdPlace: ckRecordIdPlace, placeName: placeName, userEmail: $userEmail)
                            }
                            .sheet(isPresented: $showSignInSheet) {
                                SignInView(onSuccess: { firstName, lastName, email in
                                    // Handle successful sign-in by showing AddReviewView
                                    showSignInSheet = false
                                    showAddReviewSheet = true
                                    userEmail = email
                                    userIdGlobal = userIdGlobal
                                })
                                .environmentObject(authManager)
                                
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
            .onAppear {
                checkIfUserLikesReview(userId: userIdGlobal) { likedReviewIDs in

                    fetchDataPlaceReviewFromCloudkit(recordTypes: ["Review"], placeId: ckRecordIdPlace, userId: userIdGlobal, likedReviewIDs: likedReviewIDs) { responses, likedResponses  in
                        reviewResponses = responses ?? []
                        mostLikedReviewResponse = likedResponses ?? nil
                    }
                    fetchDataFacilityFromMostLikedReview(reviewId: mostLikedReviewResponse?.ckRecordIdReview ?? CKRecord.ID(recordName: "default")) { dataFacilities in
                        isFacilitiesAvailable = dataFacilities

                    }

                }


            }
        }
        .navigationBarHidden(true)
        
    }
    private func openMaps() {
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
