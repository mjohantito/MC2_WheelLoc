//
//  NearbyHealthFacilitiesCardView.swift
//  MC2_WheelHelp
//
//  Created by Michael Chandra on 22/06/23.
//

import SwiftUI

struct NearbyHealthFacilitiesCardView: View {
    
    @State public var imageURL: URL
    @State public var placeName: String
    @State public var address: String
    //    let jam: String
    @State public var kategori: String
    @State public var fsq_id: String
    @State public var latitude: Double
    @State public var longitude: Double
    
    init(imageURL: URL, placeName: String, address: String, kategori: String, fsq_id:String, latitude:Double, longitude: Double) {
        self._imageURL = State(initialValue: imageURL)
        self._placeName = State(initialValue: placeName)
        self._address = State(initialValue: address)
        self._kategori = State(initialValue: kategori)
        self._fsq_id = State(initialValue: fsq_id)
        self._latitude = State(initialValue: latitude)
        self._longitude = State(initialValue: longitude)
    }
    
    
//    let imageNearbyFacilites: String
//    let titleNearbyFacilities: String
//    let categoryNearbyFacilities: String
//    let distanceNearbyFacilities: Double
    
    var body: some View {
        
        Button(action: {
            openMaps()
        }) {
            HStack{
    //            Image(imageNearbyFacilites)
    //                .resizable()
    //                .frame(width: 80, height: 100, alignment: .leading)
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .frame(width: 80, height: 100, alignment: .leading)
                        .cornerRadius(10)
                } placeholder: {
                    // Placeholder image or activity indicator
                    Image("BebekTepiSawah")
                        .resizable()
                        .frame(width: 80, height: 100, alignment: .leading)
                        .cornerRadius(10)
                }
                VStack(alignment: .leading){
                    
                    Text(placeName)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text(kategori)
                        .padding(.bottom,8)
                        .font(.system(size: 12))
                        .foregroundColor(.primary)
                    HStack{
                        Image(systemName: "location.fill")
                            .foregroundColor(.primary)
    //                    Text("\(String(distanceNearbyFacilities)) km")
//                            .foregroundColor(.primary)
                    }
                    
                }.padding()

            }
            .padding(.trailing)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            
        }
        
    }
    private func openMaps() {
//            let latitudeString = String(latitude)
//            let longitudeString = String(longitude)
//
//            if let url = URL(string: "http://maps.apple.com/?ll=\(latitudeString),\(longitudeString)") {
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)
//            }
        let encodedPlaceName = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            if let url = URL(string: "http://maps.apple.com/?address=\(encodedPlaceName)") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}

struct NearbyHealthFacilitiesCardView_Previews: PreviewProvider {
    static var previews: some View {
//        NearbyHealthFacilitiesCardView(imageNearbyFacilites: "national-hospital", titleNearbyFacilities: "National Hospital", categoryNearbyFacilities: "Rumah Sakit", distanceNearbyFacilities: 4.5)
        NearbyHealthFacilitiesCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "default", address: "default", kategori: "default", fsq_id: "default", latitude: 1.0, longitude: 1.0)
    }
}
