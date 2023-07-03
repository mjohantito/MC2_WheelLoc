//
//  SignInView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

import AuthenticationServices
import SwiftUI

struct SignInView: View {
    @Environment(\.colorScheme) var colorScheme
    
    
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @State var userId: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Sebelum melakukan review, harap melakukan Log In terlebih dahulu")
                    .multilineTextAlignment(.center)
                Spacer()
                Text("gambar")
                Spacer()
                
                
                SignInWithAppleButton(.continue) {request in
                    
                    request.requestedScopes = [.email, .fullName]
                    
                    
                } onCompletion: { result in
                    
                    switch result {
                    case.success(let auth):
                        
                        switch auth.credential{
                        case let credential as ASAuthorizationAppleIDCredential:
                            
                            //user ID
                            let userid = credential.user
                            
                            //user info
                            let email = credential.email
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            
                            self.userId = userid
                            self.email = email ?? ""
                            self.firstName = firstName ?? ""
                            self.lastName = lastName ?? ""
                            
                        default:
                            break
                        }
                        
                        
                    case.failure(let error):
                        print(error)

                    }
                    
                }
                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                
                .frame(height : 50)
                .padding()
                .cornerRadius(8)
            }
            .navigationTitle("Log In")
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
