//
//  PlaceDetailReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct PlaceDetailReviewView: View {
    
    @State public var reviewResponses: [ReviewResponse]
        @State public var placeId: CKRecord.ID
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                     ForEach(reviewResponses, id: \.ckRecordIdReview) { review in
                         ReviewCardView(
                             userFName: review.firstName,
                             userLName: review.lastName,
                             dateReview: review.date,
                             titleReview: review.title,
                             descriptionReview: review.description,
                             likesReview: Int(review.likes),
                             ratingReview: review.accessibilityRating,
                             ckRecordIdReview: review.ckRecordIdReview,
                             ckRecordIDPlace: review.placeId,
 //                            userId: userIdGlobal,
                             isLiked: review.isLiked
                         )
                     }
                 }
//                VStack(alignment: .leading){
//                    ForEach(reviewViews, id: \.ckRecordIdReview) { view in
//                        view
//                            .padding()
//                    }
//                }
//                .onAppear {
//                    fetchDataPlaceReviewFromCloudkit(recordTypes: ["Review"], placeId: placeId) { views in
//                        reviewViews = views
//                    }
//                }

                Spacer()
            }.padding(.top,16)
        } .navigationTitle("Ulasan")
    }
}

struct PlaceDetailReviewView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailReviewView(reviewResponses: [], placeId: CKRecord.ID(recordName: "default"))
    }
}
