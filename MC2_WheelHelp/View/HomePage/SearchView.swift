//
//  SearchView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 22/06/23.
//

import SwiftUI

struct SearchView: View {
    @State private var search = ""
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    ForEach (0..<3, id: \.self){_ in
                        KategoriCardView(imageURL: URL(string: "https://fastly.4sqi.net/img/general/100x100/12259266_cx_Jge3F8nlmV-h0Jgg_s35sIbb7LCxdEYjDGojruIw.jpg")!, placeName: "Test", address: "Somewhere over the rainbow", kategori: "Resto", rating: 2.2, jumlahUlasan: 5, fsq_id: "123", latitude: 1.0, longitude: 1.0, health_facilities_id: ["default"])
                            .padding(.horizontal, 8)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            //Search Bar
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Cari Restoran & Cafe, Tempat Wisata, Hotel dan Tempat Belanja")
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
