//
//  NearbyHealthFacilitiesCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 22/06/23.
//

import SwiftUI

struct NearbyHealthFacilitiesCardView: View {
    
    
    let imageNearbyFacilites: String
    let titleNearbyFacilities: String
    let categoryNearbyFacilities: String
    let distanceNearbyFacilities: Double
    
    var body: some View {
        HStack{
//            Image(imageNearbyFacilites)
//                .resizable()
//                .frame(width: 80, height: 100, alignment: .leading)

            VStack(alignment: .leading){
                
                Text(titleNearbyFacilities)
                    .fontWeight(.semibold)
                Text(categoryNearbyFacilities)
                    .padding(.bottom,8)
                    .font(.system(size: 12))
                HStack{
                    Image(systemName: "location.fill")
                    Text("\(String(distanceNearbyFacilities)) km")
                }
                
            }.padding()

        }
        .padding(.trailing)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(.gray, lineWidth: 1)
        )
    }
}

struct NearbyHealthFacilitiesCardView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyHealthFacilitiesCardView(imageNearbyFacilites: "national-hospital", titleNearbyFacilities: "National Hospital", categoryNearbyFacilities: "Rumah Sakit", distanceNearbyFacilities: 4.5)
    }
}
