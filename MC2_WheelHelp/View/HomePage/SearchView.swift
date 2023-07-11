//
//  SearchView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 22/06/23.
//

import SwiftUI
import CloudKit

struct SearchView: View {
    @State private var search = ""
    @State private var categoryViews: [KategoriCardView] = []
    var notfound = false
    
    var body: some View {
        NavigationStack{
            
            VStack{
                if(notfound == true){
                    Spacer()
                    Image("Empty State")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                    Text("Pencarian Tidak Ditemukan")
                        .font(.title2.bold())
                        .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                    Spacer()
                }else{
                    ScrollView{
                        ForEach(categoryViews, id: \.placeName) { view in
                            view
                                .padding(.horizontal, 8)
                        }

                    }
                    .onAppear {
                        fetchDataPlaceFromCloudKit(recordTypes: ["Place"], nama: search) { views in
                            categoryViews = views
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            //Search Bar
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Cari Restoran & Cafe, Tempat Wisata, Hotel dan Pusat Belanja")
            
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
