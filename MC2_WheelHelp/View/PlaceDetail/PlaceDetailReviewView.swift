//
//  PlaceDetailReviewView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct PlaceDetailReviewView: View {
    
    @State private var reviewViews: [ReviewCardView] = []
    @State public var placeId: CKRecord.ID
    
    var body: some View {
        NavigationStack{
            ScrollView{
//                ForEach (0..<3, id: \.self){_ in
//                    ReviewCardView(userFName: "Angelo", userLName: "Kusuma", dateReview: Date(), titleReview: "Bagus Banget!", descriptionReview: "Disini fasilitas buat pengguna kursi roda aman banget, bahkan toiletnya disediain khusus buat disabilitas!", likesReview: 0, ratingReview: 1.0)
//                }
                VStack(alignment: .leading){
                    ForEach(reviewViews, id: \.ckRecordIdReview) { view in
                        view
                            .padding()
                    }
                }
                .onAppear {
                    fetchDataPlaceReviewFromCloudkit(recordTypes: ["Review"], placeId: placeId) { views in
                        reviewViews = views
                    }
                }

                Spacer()
            }.padding(.top,16)
        } .navigationTitle("Ulasan")
    }
}

struct PlaceDetailReviewView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailReviewView(placeId: CKRecord.ID(recordName: "default"))
    }
}
