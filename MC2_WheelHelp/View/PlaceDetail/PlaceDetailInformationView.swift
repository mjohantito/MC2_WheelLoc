//
//  PlaceDetailInformationView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 21/06/23.
//

import SwiftUI
import CloudKit

struct PlaceDetailInformationView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var authManager: AuthManager
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var showSignInSheet = false
    @State private var showAddReviewSheet = false
    @State private var userEmail: String = ""
    @AppStorage("userIdGlobal") var userIdGlobal: String = ""
    @State var showSheet = false
    @State private var showFacilityView = false
    
    @State private var categoryViews: [NearbyHealthFacilitiesCardView] = []
    @State private var reviewResponses: [ReviewResponse] = []
    @State private var mostLikedReviewResponse: ReviewResponse?
    @State public var isFacilitiesAvailable: FacilityFromReviewResponse?
    
    @State private var imageURLs: [URL]
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
    @State private var currentTab = 0
    
    
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
        NavigationStack{
            ScrollView {
                ZStack (alignment: .leading){
                    if imageURLs.isEmpty {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
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
                    // Section Nama Tempat & Rating
                    VStack{
                        Text(placeName)
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
                        ForEach(1..<6) { index in
                            if index <= Int(rating) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color.yellow)
                            } else if index - 1 == Int(rating) && rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
                                Image(systemName: "star.leadinghalf.filled")
                                    .foregroundColor(Color.yellow)
                            } else {
                                Image(systemName: "star")
                                    .foregroundColor(Color.yellow)
                            }
                        }
                        
                        Text("\(rating, specifier: "%.1f")")
                            .fontWeight(.bold)
                        
                        Text("(\(jumlahUlasan))")
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
                            NavigationLink(destination: PlaceDetailFacilityView(dataFacilitiesResponse: $mostLikedReviewResponse)){
                                Text("Lihat Semua")
                            }
//                            NavigationLink(destination: PlaceDetailFacilityView()){
//                                Text("Lihat Semua")
//                            }
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
                                            .foregroundColor(Color.black)
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
                                        Text("Escalator")
                                            .foregroundColor(Color.black)
                                    } else {
                                        Image("escalator")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.gray)
                                        Text("Escalator")
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
                                            .foregroundColor(Color.black)
                                    } else {
                                        Image("ramp-loading")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.gray)
                                        Text("Ramp")
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
                                            .foregroundColor(Color.black)
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
                                            .foregroundColor(Color.black)
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
                                            .border(.red)
                                        Text("Tempat Parkir")
                                            .foregroundColor(Color.black)
                                    } else {
                                        Image("wheelchairSmall")
                                            .resizable()
                                            .frame(width: 30, height: 30, alignment: .leading)
                                            .foregroundColor(Color.gray)
                                        Text("Tempat Parkir")
                                            .foregroundColor(Color.gray)
                                    }
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
                        NavigationLink(destination: PlaceDetailReviewView(reviewResponses: reviewResponses, placeId: ckRecordIdPlace)){
                            Text("Lihat Semua")
                        }
                    }
                    
                    // Slider Top 3 Ulasan
                    
                    ScrollView(.horizontal, showsIndicators: false) {
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
    
}

struct PlaceDetailInformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            PlaceDetailInformationView(imageURLs: [URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!], placeName: "Bebek Tepi Sawah", address: "Jalan Diponegoro No.87, Surabaya", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: [], ckRecordIdPlace: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"))
        }
    }
}
