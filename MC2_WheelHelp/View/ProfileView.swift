//
//  ProfileView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Form{
            Section{
                HStack{
                    Text("gambar")
                    VStack{
                        HStack{
                            Text("Angelo Kusuma")
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        HStack{
                            Text("administrator1@icloud.com")
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                }
            }
            Section{
                Text("Reviews")
                Spacer()
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
