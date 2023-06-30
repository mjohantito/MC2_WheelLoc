//
//  ButtonGenerateDataView.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 23/06/23.
//

import SwiftUI

struct ButtonGenerateDataView: View {
    
    @StateObject var foursquareAPI = FoursquareAPI()
    @State private var imagesData: [images]? = nil
    @State private var healthFacilitesData: [HealthFacilities]? = nil
    var body: some View {
        VStack {
            Button(action: {
                buttonPlacesTapped()
            }) {
                Text("Generate Places Data")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }.padding(.bottom, 30)
            Button(action: {
                buttonHealthFacilitiesTapped()
            }) {
                Text("Generate Health Facilities Data")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }
        
    }
    
    
    func buttonPlacesTapped() {
        foursquareAPI.fetchPlacesandImages()
        print("Button tapped")
        
    }
    func buttonHealthFacilitiesTapped() {
        let ll = "39.044804,-77.476121"
        foursquareAPI.fetchNearestHealthFacilities(ll: ll)
//        Task.init {
//            await foursquareAPI.fetchNearestHealthFacilities(ll: ll)
//
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//
//            let jsonDataNew = try encoder.encode(foursquareAPI.placeResults2)
//            if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
//
//                print("\(jsonString)")
//
//            }
//        }
        print("Button tapped")
        
    }
    //    func fetchImages() {
    //        foursquareAPI.fetchImagesPlaces(fsq_id: fsq_id) { fetchedImagesData in
    //            DispatchQueue.main.async {
    //                self.imagesData = fetchedImagesData
    //            }
    //        }
    //    }
    
    //    func fetchHealthFacilities() {
    //        let ll = "39.044804,-77.476121"
    //        foursquareAPI.fetchNearestHealthFacilities(ll: ll) { fetchedHealthFacilitiesData in
    //            DispatchQueue.main.async {
    //                self.healthFacilitesData = fetchedHealthFacilitiesData
    //            }
    //        }
    //    }
}

struct ButtonGenerateDataView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonGenerateDataView()
    }
}
