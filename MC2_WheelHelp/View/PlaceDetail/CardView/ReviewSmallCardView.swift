//
//  ReviewSmallCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 22/06/23.
//

import SwiftUI
import CloudKit

struct ReviewSmallCardView: View {
    
    @State private var userFName: String
    @State private var userLName: String
    @State private var dateReview: Date
    @State private var titleReview: String
    @State private var descriptionReview: String
    @State private var likesReview: Int
    @State private var ratingReview: Double
    @State public var ckRecordIdReview: CKRecord.ID
    @State public var ckRecordIdPlace: CKRecord.Reference
    @State public var isLiked: Bool
    init(userFName: String, userLName: String, dateReview: Date, titleReview: String, descriptionReview: String, likesReview: Int, ratingReview: Double, ckRecordIdReview: CKRecord.ID, ckRecordIDPlace: CKRecord.Reference, isLiked: Bool) {
        self._userFName = State(initialValue: userFName)
        self._userLName = State(initialValue: userLName)
        self._dateReview = State(initialValue: dateReview)
        self._titleReview = State(initialValue: titleReview)
        self._descriptionReview = State(initialValue: descriptionReview)
        self._likesReview = State(initialValue: likesReview)
        self._ratingReview = State(initialValue: ratingReview)
        self._ckRecordIdReview = State(initialValue: ckRecordIdReview)
        self._ckRecordIdPlace = State(initialValue: ckRecordIDPlace)
        self._isLiked = State(initialValue: isLiked)
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
                            .foregroundColor(Color.orange)
                            .frame(width: 14, height: 22, alignment: .leading)
                    }
                    
                    Spacer()
                }
                .frame(alignment: .leading)
                .padding(.bottom, 20)
                Text(descriptionReview)
                    .padding(.bottom,8)
                    .font(.system(size: 12))
                HStack{
                    Text("Angelo K.")
                        .fontWeight(.semibold)
                        .font(.system(size: 12))
                    
                    Spacer()
                    
                    Text("30 Mar 2023")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
            }
        }
        .padding()
        .frame(width: 300, height: 180)
        .background(Color(red: 0.96, green: 0.96, blue: 0.96))
        .cornerRadius(10)
    }
    
}

struct ReviewSmallCardView_Previews: PreviewProvider {
    static var previews: some View {
        let response = fetchDummyDataPlaceFromCloudKit()
        
        ReviewSmallCardView(userFName: "Angelo", userLName: "Kusuma", dateReview: Date(), titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!", likesReview: 0, ratingReview: 1.0, ckRecordIdReview: CKRecord.ID(recordName: "3D204835-A7D5-4F80-8A7F-632C2CB1FBA8"), ckRecordIDPlace: CKRecord.Reference(recordID: response.ckRecordIdPlace, action:.none), isLiked: false)
    }
}
