//
//  ProfileView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

import SwiftUI

struct ProfileView: View {
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
                                Text("Angelo Kusuma") // request dari apple account
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            HStack{
                                Text("administrator1@icloud.com") // request dari apple account
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
            }
            .navigationTitle("Akun")

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
