//
//  CategoryListView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI

struct CategoryListView: View {
    
    let kategori: String
    @State private var search = ""
    @State private var categoryViews: [CategoryListCardView] = []
    
    var body: some View {
//        NavigationStack{
            ScrollView {
                
                //Scroll View List
                VStack(alignment: .leading){
                    ForEach(categoryViews, id: \.placeName) { view in
                        view
                            .padding()
                    }
                }
                .onAppear {
                    fetchDataPlaceFromCloudKit(recordTypes: ["Place"], category: kategori) { views in
                        categoryViews = views
                    }
                }
                
            }
            //Search Bar
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
//        }
        .navigationBarTitle(kategori)
        
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(kategori: "Restoran & Cafe")
    }
}
