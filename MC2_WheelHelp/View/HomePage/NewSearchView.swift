//
//  NewSearchView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 12/07/23.
//

import SwiftUI
import CloudKit

struct NewSearchView: View {
    @State private var searchText = ""
    @State private var categoryViews: [KategoriCardView] = []
    
    var body: some View {
        NavigationStack{
            VStack{
                if categoryViews.isEmpty {
                    Spacer()
                    Image("Empty State")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200)
                    Text("Pencarian Tidak Ditemukan")
                        .font(.title2.bold())
                        .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                    Spacer()
                } else {
                    ScrollView{
                        ForEach(categoryViews, id: \.placeName) { view in
                            view
                                .padding(.horizontal, 8)
                        }

                    }

                }
                                
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Cari Restoran & Cafe, Tempat Wisata, Hotel dan Pusat Belanja")
            .onChange(of: searchText) { searchText in
                if searchText.isEmpty{
                    fetchDataSearchPlaceFromCloudKit(recordTypes: ["Place"], name: "") { views in
                        categoryViews = views
                        print("nama empty : \(searchText)")
                        print(views)
                    }
                } else {
                    fetchDataSearchPlaceFromCloudKit(recordTypes: ["Place"], name: searchText) { views in
                        categoryViews = views
                        print("nama not empty: \(searchText)")
                        print(views)
                    }

                }
                // if object empty
                
                    
            }
            
        }
    }    
}

struct NewSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NewSearchView()
    }
}
