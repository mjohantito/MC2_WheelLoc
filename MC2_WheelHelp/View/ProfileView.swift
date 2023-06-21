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
                        Text("nama")
                        Text("email")
                    }
                }
            }
            Section{
                Text("Reviews")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
