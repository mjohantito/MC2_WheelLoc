//
//  FacilityCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct FacilityCardView: View {
//
//    @Binding public var dataFacilitiesResponse: ReviewResponse?
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                HStack {
                    Image("elevator")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .leading)
                    .foregroundColor(Color.black)
                    Text("Lift")
                }
                .padding()
                .frame(alignment: .leading)

                HStack{
                    Text("•")
                    Text("Lantai UG - Depan Hypermart")
                }.padding(.bottom,8)
                Spacer()
            }
            .padding()
            .frame(width: 350, alignment: .leading)
            .background(Color(red: 0.96, green: 0.96, blue: 0.96))
            .cornerRadius(10)
            
            
        }
        
    }
}

struct FacilityCardView_Previews: PreviewProvider {
    static var previews: some View {
//        FacilityCardView(dataFacilitiesResponse: .constant(ReviewResponse(accessibilityRating: 1.0, entrance: "", date: Date(), description: "", escalatorFloor: [""], escalatorLocation: [""], firstName: "", placeId: CKRecord.Reference(recordID: CKRecord.ID(recordName: "default"), action: .none), lastName: "", liftFloor: [""], liftLocation: [""], likes: 0, placeName: "", ramp: "", wheelchairAvailable: "", parking: "", title: "", toiletFloor: [""], toiletLocation: [""], ckRecordIdReview: CKRecord.ID(recordName: "default"), isLiked: false)))
        FacilityCardView()
    }
}
