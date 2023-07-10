//
//  ReviewCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct ReviewCardView: View {

    @State private var userFName: String
    @State private var userLName: String
    @State private var dateReview: Date
    @State private var titleReview: String
    @State private var descriptionReview: String
    @State private var likesReview: Int
    @State private var ratingReview: Double
    @State public var ckRecordIdReview: CKRecord.ID
    @State public var ckRecordIdPlace: CKRecord.Reference
    
    init(userFName: String, userLName: String, dateReview: Date, titleReview: String, descriptionReview: String, likesReview: Int, ratingReview: Double, ckRecordIdReview: CKRecord.ID, ckRecordIDPlace: CKRecord.Reference) {
        self._userFName = State(initialValue: userFName)
        self._userLName = State(initialValue: userLName)
        self._dateReview = State(initialValue: dateReview)
        self._titleReview = State(initialValue: titleReview)
        self._descriptionReview = State(initialValue: descriptionReview)
        self._likesReview = State(initialValue: likesReview)
        self._ratingReview = State(initialValue: ratingReview)
        self._ckRecordIdReview = State(initialValue: ckRecordIdReview)
        self._ckRecordIdPlace = State(initialValue: ckRecordIDPlace)
    }
    
    var body: some View {
        HStack{

            VStack(alignment: .leading){
                
                Text(titleReview)
                    .fontWeight(.semibold)
                    .padding(.bottom, 1)
                HStack {
                    
                    ForEach (1..<6) { _ in
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                            .padding(.horizontal, -2.5)
                    }
    
                    Text("5.0")
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(alignment: .leading)
                .padding(.bottom, 10)
                Text(descriptionReview)
                    .padding(.bottom,8)
                    .font(.footnote)
                HStack {
                    Image("BebekTepiSawah")
                        .resizable()
                        .frame(width:70, height:60)
                        .cornerRadius(10)
                    Image("BebekTepiSawah")
                        .resizable()
                        .frame(width:70, height:60)
                        .cornerRadius(10)
                }
                .padding(.bottom,8)
                HStack {
                    Text(userFName)
                        .font(.footnote)
                        .bold()
                    Spacer()
                    LikeButtonView(likesCount: Int64(likesReview), ckRecordIdReview: ckRecordIdReview)
//                    Image(systemName: "hand.thumbsup.fill")
//                        .resizable()
//                        .frame(width:18, height:18)
//                    Text("30")
//                        .font(.footnote)
                    
                }
            }
        }
        .padding()
        .frame(width: 350, height: 250)
        // ini nanti diganti background color nya jadi white
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .cornerRadius(10)
    }
    
}

struct ReviewCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        let response = fetchDummyDataPlaceFromCloudKit()
        
        ReviewCardView(userFName: "Angelo", userLName: "Kusuma", dateReview: Date(), titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!", likesReview: 0, ratingReview: 1.0, ckRecordIdReview: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"), ckRecordIDPlace: CKRecord.Reference(recordID: response.ckRecordIdPlace, action:.none))
    }
}
