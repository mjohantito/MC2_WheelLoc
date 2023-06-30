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
            ScrollView {
                
                //Scroll View List
                VStack(alignment: .leading){
                    ForEach(0..<10, id: \.self){ _ in
                        CategoryListCardView(image: "BebekTepiSawah", title: "Bebek Tepi Sawah", subtitle: "Jalan Diponegoro No.87, Surabaya", jam: "07.00 - 20.00", kategori: "Restoran Keluarga", rating: 2.2, jumlahUlasan: 5)
                            .padding(.horizontal, 8)
                    }
                }
                
            }
            //Search Bar
            .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
        }
        
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
