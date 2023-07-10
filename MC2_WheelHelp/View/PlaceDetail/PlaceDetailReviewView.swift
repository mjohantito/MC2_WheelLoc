//
//  PlaceDetailReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct PlaceDetailReviewView: View {
    
    @State private var reviewResponses: [ReviewResponse] = []
    @State public var placeId: CKRecord.ID
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(reviewResponses, id: \.ckRecordIdReview) { review in
                        let a = print(review.first_name)
                            ReviewCardView(
                                userFName: review.first_name,
                                userLName: review.last_name,
                                dateReview: review.date,
                                titleReview: review.title,
                                descriptionReview: review.description,
                                likesReview: Int(review.likes),
                                ratingReview: review.accessibilityRating,
                                ckRecordIdReview: review.ckRecordIdReview,
                                ckRecordIDPlace: review.placeId
                            )
                        }
//                    ForEach(reviewViews, id: \.ckRecordIdReview) { view in
//                        view
//                            .padding()
//                    }
                }

                Spacer()
            }
            .padding(.top,16)
            .onAppear {
                fetchDataPlaceReviewFromCloudkit(recordTypes: ["Review"], placeId: placeId) { responses in
                    reviewResponses = responses ?? []
                }
            }
        } .navigationTitle("Ulasan")
    }
}

struct PlaceDetailReviewView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailReviewView(placeId: CKRecord.ID(recordName: "default"))
    }
}
