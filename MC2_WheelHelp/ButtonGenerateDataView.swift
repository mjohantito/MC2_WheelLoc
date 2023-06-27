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
//    @State private var healthFacilitesData: [HealthFacilities]? = nil
    var body: some View {
        Button(action: {
                    // Action to perform when the button is tapped
                    buttonTapped()
                }) {
                    Text("Generate Data")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
    }
    
    
    func buttonTapped() {
        // Handle button tap action here
        foursquareAPI.fetchPlacesandImages()
//        foursquareAPI.fetchNearestHealthFacilities(ll: "39.044804,-77.476121")
//        fetchHealthFacilities()
//        fetchImages()
        print("Button tapped")
        
    }
    func fetchImages() {
        let fsq_id = "4bc2a3ec4cdfc9b66c6f9621" // Replace with the actual fsq_id
        
        foursquareAPI.fetchImagesPlaces(fsq_id: fsq_id) { fetchedImagesData in
            DispatchQueue.main.async {
                self.imagesData = fetchedImagesData
            }
        }
    }
    
//    func fetchHealthFacilities() {
//        let ll = "39.044804,-77.476121"
//
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
