//
//  SignInView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

import AuthenticationServices
import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authManager: AuthManager
    var onSuccess: (String) -> Void
    @Environment(\.colorScheme) var colorScheme
    
//    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("userId") var userId: String = ""
    
    @Binding var userEmail: String
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Sebelum melakukan review, harap melakukan Log In terlebih dahulu")
                    .multilineTextAlignment(.center)
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 320, height: 300)
                Text("Wheeloc")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("customPrimary"))
                Text("Get the best experience")
                Spacer()
                
                
                SignInWithAppleButton(.continue) {request in
                    request.requestedScopes = [.email, .fullName]
                } onCompletion: { result in
                    
                    switch result {
                    case.success(let auth):
                        
                        switch auth.credential{
                        case let credential as ASAuthorizationAppleIDCredential:

                            let userid = credential.user
                            let email = credential.email
                            let firstName = credential.fullName?.givenName
                            let lastName = credential.fullName?.familyName
                            
                            self.userEmail = email ?? ""

                            // Update other properties if needed
                            self.firstName = firstName ?? ""
                            self.lastName = lastName ?? ""
                            self.userId = userid
                            
                            authManager.isSignedIn = true
                            onSuccess(userEmail)
                            print("sign in view: \(userEmail)")
                            
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
                .cornerRadius(10)
            }
            .navigationTitle("Log In")
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    @State static var userEmail = ""
    static var previews: some View {
        SignInView(onSuccess: { email in }, userEmail: $userEmail)
    }
}
