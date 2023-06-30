//
//  PlaceDetailFacilityView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 30/06/23.
//

import SwiftUI

struct PlaceDetailFacilityView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach (0..<3, id: \.self){_ in
                    FacilityCardView()
                }
                
            }
            .padding(.top,24)
        }.navigationTitle("Fasilitas")
    }
}

struct PlaceDetailFacilityView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailFacilityView()
    }
}
