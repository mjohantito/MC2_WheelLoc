//
//  SignInView.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 21/06/23.
//

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
    
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
//    @State private var userId: String = ""
    
    @Binding var userEmail: String
    @Binding var userId: String
    
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
                            
                            addUsersToCloudKit(fName: firstName ?? "", lName: lastName ?? "")
                            
                            authManager.isSignedIn = true
                            onSuccess(userEmail)
//                            print("USERID: \(userid) - \(email)")
                            
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
    @State static var userId = ""
    static var previews: some View {
        SignInView(onSuccess: { email in }, userEmail: $userEmail, userId: $userId)
    }
}

// SIGN IN VERSI TITO
//import AuthenticationServices
//import SwiftUI
//
//struct AppleUser: Codable {
//    let userId: String
//    let firstName: String
//    let lastName: String
//    let email: String
//
//    init?(credentials: ASAuthorizationAppleIDCredential){
//        guard
//            let firstName = credentials.fullName?.givenName,
//            let lastName = credentials.fullName?.familyName,
//            let email = credentials.email
//        else {return nil}
//
//        self.userId = credentials.user
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//    }
//}
//
//struct SignInView: View {
//    @EnvironmentObject var authManager: AuthManager
//    var onSuccess: () -> Void
//    @Environment(\.colorScheme) var colorScheme
//    //    @AppStorage("email") var email: String = ""
//    //    @AppStorage("firstName") var firstName: String = ""
//    //    @AppStorage("lastName") var lastName: String = ""
//    //    @State var userId: String = ""
//    //    @Binding var userEmail: String
//    @State var appleUserId: String
//    @State var appleUserFName: String
//    @State var appleUserLName: String
//
//    var body: some View {
//        NavigationStack{
//            VStack{
//                Text("Sebelum melakukan review, harap melakukan Log In terlebih dahulu")
//                    .multilineTextAlignment(.center)
//                Spacer()
//                Image("logo")
//                    .resizable()
//                    .frame(width: 320, height: 300)
//                Text("Wheeloc")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(Color("customPrimary"))
//                Text("Get the best experience")
//                Spacer()
//
//                SignInWithAppleButton(.signIn,
//                                      onRequest: configure,
//                                      onCompletion: handle)
//                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
//                .frame(height: 45)
//                .padding()
//                //                SignInWithAppleButton(.continue) {request in
//                //                    request.requestedScopes = [.email, .fullName]
//                //                } onCompletion: { result in
//                //
//                //                    switch result {
//                //                    case.success(let auth):
//                //
//                //                        switch auth.credential{
//                //                        case let credential as ASAuthorizationAppleIDCredential:
//                //
//                //                            let userid = credential.user
//                //                            let email = credential.email
//                //                            let firstName = credential.fullName?.givenName
//                //                            let lastName = credential.fullName?.familyName
//                //
//                //                            self.userEmail = email ?? ""
//                //
//                //                            // Update other properties if needed
//                //                            self.firstName = firstName ?? ""
//                //                            self.lastName = lastName ?? ""
//                //                            self.userId = userid
//                //
//                //                            authManager.isSignedIn = true
//                //                            onSuccess(userEmail)
//                //                            print("sign in view: \(userEmail)")
//                //
//                //                        default:
//                //                            break
//                //                        }
//                //
//                //
//                //
//                //                    case.failure(let error):
//                //                        print(error)
//                //
//                //                    }
//                //
//                //                }
//                //                .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
//                //                .frame(height : 50)
//                //                .padding()
//                //                .cornerRadius(10)
//            }
//            .navigationTitle("Log In")
//            .padding()
//        }
//    }
//
//    func configure(_ request: ASAuthorizationAppleIDRequest){
//        request.requestedScopes = [.fullName, .email]
//        //        request.nonce = ""
//
//    }
//    func handle(_ authResult: Result<ASAuthorization, Error>){
//        switch authResult {
//        case .success(let auth):
//            print(auth)
//            print("LEWAT1")
//            switch auth.credential {
//            case let appleIdCredentials as ASAuthorizationAppleIDCredential:
//                if let appleUser = AppleUser(credentials: appleIdCredentials),
//                   let appleUserData = try? JSONEncoder().encode(appleUser) {
//                    print("LEWAT2")
//                    UserDefaults.standard.setValue(appleUserData, forKey: appleUser.userId)
//                    appleUserId = appleUser.userId
//                    appleUserFName = appleUser.firstName
//                    appleUserLName = appleUser.lastName
//                    print("saved apple user", appleUser)
//                    print("LEWAT3")
//                }
//                authManager.isSignedIn = true
//                onSuccess()
//                addUsersToCloudKit(fName: appleUserFName, lName: appleUserLName, userAppleId: appleUserId)
//
//            default:
//                print(auth.credential)
//            }
//        case . failure(let error):
//            print(error)
//        }
//    }
//}
//
//struct SignInView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        SignInView(onSuccess: { email in }, userEmail: $userEmail)
//        SignInView(onSuccess: {}, appleUserId: "default", appleUserFName: "default", appleUserLName: "default")
//
//    }
//}
