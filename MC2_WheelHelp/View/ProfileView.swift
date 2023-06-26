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
                    Image(systemName: "person.circle")
                      .resizable()
                      .frame(width: 60, height: 60)
                      .foregroundColor(.black)
                      .padding(10)
                      .background(Color.white)
                      .clipShape(Circle())
                    
                    VStack(alignment: .leading){
                        Text("Angelo Kusuma")
                            .font(.headline)
                        
                        Text(verbatim: "administrator@icloud.com")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            Section{
                HStack{
                    Text("Reviews")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
