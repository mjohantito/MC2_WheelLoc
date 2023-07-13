//
//  PlaceDetailFacilityView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI
import CloudKit

struct PlaceDetailFacilityView: View {
    
    @Binding public var dataFacilitiesResponse: ReviewResponse?
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                
                //                              Lift
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
                    
                    if let liftFloor = dataFacilitiesResponse?.liftFloor,
                       let liftLocation = dataFacilitiesResponse?.liftLocation {
                        if !liftFloor.isEmpty {
                            ForEach(liftFloor.indices, id: \.self) { index in
                                HStack {
                                    Text("•")
                                    Text("\(liftFloor[index]) - \(liftLocation[index])")
                                }
                                .padding(.bottom, 8)
                                Spacer()
                            }
                        } else {
                            HStack {
                                Text("Tidak tersedia lift")
                            }
                            .padding(.bottom, 8)
                            Spacer()
                        }
                    }
                }
                .padding()
                .frame(width: 350, alignment: .leading)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .cornerRadius(10)
                
                //Escalator
                VStack(alignment: .leading){
                    HStack {
                        Image("escalator")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .leading)
                            .foregroundColor(Color.black)
                        Text("Eskalator")
                    }
                    .padding()
                    .frame(alignment: .leading)
                    
                    if let escalatorFloor = dataFacilitiesResponse?.escalatorFloor,
                       let escalatorLocation = dataFacilitiesResponse?.escalatorLocation {
                        if !escalatorFloor.isEmpty {
                            ForEach(escalatorFloor.indices, id: \.self) { index in
                                HStack {
                                    Text("•")
                                    Text("\(escalatorFloor[index]) - \(escalatorLocation[index])")
                                }
                                .padding(.bottom, 8)
                                Spacer()
                            }
                        } else {
                            HStack {
                                Text("Tidak tersedia eskalator")
                            }
                            .padding(.bottom, 8)
                            Spacer()
                        }
                    }
                }
                .padding()
                .frame(width: 350, alignment: .leading)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .cornerRadius(10)
                
            }
            .padding(.top,24)
            
        }
        .navigationTitle("Fasilitas")
    }
}

struct PlaceDetailFacilityView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailFacilityView(dataFacilitiesResponse: .constant(ReviewResponse(accessibilityRating: 1.0, entrance: "", date: Date(), description: "", escalatorFloor: [""], escalatorLocation: [""], firstName: "", placeId: CKRecord.Reference(recordID: CKRecord.ID(recordName: "default"), action: .none), lastName: "", liftFloor: [""], liftLocation: [""], likes: 0, placeName: "", ramp: "", wheelchairAvailable: "", parking: "", title: "", toiletFloor: [""], toiletLocation: [""], ckRecordIdReview: CKRecord.ID(recordName: "default"), isLiked: false)))
        //        PlaceDetailFacilityView()
    }
}
