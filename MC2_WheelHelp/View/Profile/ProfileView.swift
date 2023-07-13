//
//  ProfileView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

import SwiftUI

struct ProfileView: View {
    @State public var userDetails: UserDetailsResponse
    @EnvironmentObject var authManager: AuthManager
    @AppStorage("userIdGlobal") var userIdGlobal: String = ""
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    HStack{
                        Image("ProfilePhoto")
                            .resizable()
                            .frame(width: 70, height : 70)
                            .clipShape(Circle())// request dari apple acount
                        VStack{
                            HStack{
                                //                                Text("Angelo Kusuma") // request dari apple account
                                Text("\(userDetails.firstName) \(userDetails.lastName)")
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text(userDetails.email) // request dari apple account
                                    .fontWeight(.light)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                        }
                    }
                }
                Section{
                    HStack{
                        Text("Reviews")
                        Spacer()
                        Image(systemName: "chevron.forward")
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            authManager.signOut()
                            // Perform any additional signout operations if needed
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.red)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("Akun")
            
        }
        .onAppear {
            fetchUserDetails(appleUserID: userIdGlobal) { response in
                userDetails = response
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userDetails: UserDetailsResponse(firstName: "John", lastName: "Doe", email: "johndoe@example.com"))
    }
}
