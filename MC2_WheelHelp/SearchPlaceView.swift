//
//  SearchPlaceView.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 21/06/23.
//

import SwiftUI
import Foundation

struct SearchPlaceView: View {
    @State var searchText = ""
    @State private var isSearching = false
    @StateObject var foursquareAPI = FoursquareAPI()
    @State var fetchedPlaces = [results]()
//    @State var fetchedImage = [images]()
//    var imagesPlace = [images]()
    var userQuery = "default"
    
    var searchResults: [results]
    {
        if searchText.isEmpty {
            return []
        } else {
//            foursquareAPI.fetchPlaces(query: searchText) { (data) in
//            foursquareAPI.fetchPlaces(query: "Surabaya") { (data) in
//                switch data
//                {
//                case .success(let listOf):
//                    self.fetchedPlaces = listOf.results
//                case .failure(let error):
//                    print("Error Processing JSON Data \(error)")
//                }
//            }
            return fetchedPlaces
//            return fetchedPlaces.filter{$0.name.lowercased().contains(searchText.lowercased())}
        }
    }
    
    var body: some View {
        //        Text("Hello World")
        NavigationStack {
            VStack {
//                SearchBar(searchText: $searchText, isSearching: $isSearching)
                
                List(searchResults, id: \.self) { data in
                    HStack {
                            Text("\(data.name)")
//                            if data.categories.isEmpty {
//                                Text("Gaada")
//                            } else {
//                                Text("\(data.categories[0].name)")
//                            }
                        Spacer()
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(.gray)
//                                .frame(width: 100, height: 100)
//                            AsyncImage(url: URL(string: imgUrl))
//                                .frame(width: 100, height: 100)
//                        }
                    }
                    
//                    ForEach(imagesPlace,id:\.self) { imagePlace in
//                        let name = data.name
//                        let category = data.categories.first?.name
//                        let prefix = imagesPlace[0].prefix
//                        let size = "100x100"
//                        let suffix = imagesPlace[0].suffix
//                        let imgUrl = prefix+size+suffix
//
//
//                    }
                }
                .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always))
//                    .onChange(of: $searchText, perform: { newValue in
//                        foursquareAPI.fetchPlaces(query: userQuery) { (data) in
//                            switch data
//                            {
//                            case .success(let listOf):
//                                self.fetchedPlaces = listOf.results
//                            case .failure(let error):
//                                print("Error Processing JSON Data \(error)")
//                            }
//                        }
//                    })
                    
            }
            .navigationBarTitle("Search Places").font(.subheadline)
        }
        
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(.leading, 20)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .onTapGesture {
                    isSearching = true
                }
            
            if isSearching {
                Button(action: {
                    searchText = ""
                    isSearching = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(.trailing, 8)
                        .foregroundColor(.gray)
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct SearchPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceView()
    }
}
