//
//  PlaceView.swift
//  MC2_WheelHelp
//
//  Created by Angelo Kusuma on 21/06/23.
//

import SwiftUI
import CloudKit

struct PlaceView: View {
    @State private var search = ""
    @State private var categoryViews: [KategoriCardView] = []
    @EnvironmentObject var authManager: AuthManager
    @AppStorage("isSignedIn") private var isSignedIn = false
    @State private var userId: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @State private var activeTag: String = "Restoran & Cafe"
    
    var tags: [String] = [
        "Restoran & Cafe", "Tempat Wisata", "Hotel", "Pusat Belanja"
    ]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 15){
                HStack{
                    Text("Telusuri")
                        .foregroundColor(Color(red: 19/255, green: 70/255, blue: 97/255))
                        .font(.largeTitle.bold())
                        .padding(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .padding(.trailing)
                }
                .padding(.top)
                
                //Search Bar
                NavigationLink(destination: NewSearchView()){
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Cari Restoran & Cafe, Tempat Wisata, Hotel dan Tempat Belanja")
                        Spacer()
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.quaternary)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                }
                TagsView()
                
                ScrollView{
                    VStack{
                        ForEach(categoryViews, id: \.placeName) { view in
                            view
                                .padding(.horizontal, 8)
                        }
                        
                    }
                    .onAppear {
                        fetchDataPlaceFromCloudKit(recordTypes: ["Place"], category: activeTag) { views in
                            categoryViews = views
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
//             .navigationTitle("Telusuri")
//             .toolbar {
//                 ToolbarItemGroup(placement: .primaryAction){
                    
//                     if authManager.isSignedIn {
//                         NavigationLink(destination: ProfileView(userDetails: UserDetailsResponse(firstName: "", lastName: "", email: ""))) {
//                             Image(systemName: "person.circle")
//                                 .resizable()
//                                 .foregroundColor(.primary)
//                                 .scaledToFit()
//                                 .frame(width: 40, height: 40)
//                         }
//                     }
//                     else {
//                         NavigationLink(destination: SignInView(onSuccess: { firstName, lastName, email in }).environmentObject(authManager)) {
//                             Image(systemName: "person.circle")
//                                 .resizable()
//                                 .foregroundColor(.primary)
//                                 .scaledToFit()
//                                 .frame(width: 40, height: 40)
//                         }

            .background(Color.gray.opacity(0.1))
        }
    }
    
    //TagView
    @ViewBuilder
    func TagsView() -> some View {
        HStack (){
            ForEach(tags, id: \.self) { tag in
                VStack(alignment: .center){
                    Image(tag)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .padding(.top, 5)
                    
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 22)
                        .padding(.bottom, 5)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 90)
                //Active
                .onTapGesture {
                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7)) {
                        activeTag = tag
                        fetchDataPlaceFromCloudKit(recordTypes: ["Place"], category: activeTag) { views in
                            categoryViews = views
                        }
                        

                    }
                }
                .background( content: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.bar)
                })
                .font(Font.headline.weight(activeTag == tag ? .bold : .light))
                .opacity(activeTag == tag ? 1 : 0.3)
                .contentShape(Rectangle())
                .padding(.horizontal, 2)
            }

            .environmentObject(authManager)
//             .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
        }
        
        }
    }
    
    struct PlaceView_Previews: PreviewProvider {
        static var previews: some View {
            PlaceView()
        }
        
    }
}
