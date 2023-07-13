//
//  AuthManager.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 02/07/23.
//

import Foundation

class AuthManager: ObservableObject {
    @Published var isSignedIn = false
    
    init() {
        // Retrieve the sign-in state from UserDefaults
        isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    }
    
    func signIn() {
        // Perform the sign-in operation
        
        // Update the isSignedIn property
        isSignedIn = true
        
        // Save the sign-in state to UserDefaults
        UserDefaults.standard.set(true, forKey: "isSignedIn")
    }
    
    func signOut() {
        // Perform the sign-out operation
        
        // Update the isSignedIn property
        isSignedIn = false
        
        // Save the sign-in state to UserDefaults
        UserDefaults.standard.set(false, forKey: "isSignedIn")
    }
}
