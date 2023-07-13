//
//  MC2_WheelHelpApp.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 16/06/23.
//

import SwiftUI
import CloudKit

@main
struct MC2_WheelHelpApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            if(UserDefaults.standard.bool(forKey: "notFirstInApp") == false){
                OnBoardingPageView()
                    .onAppear {
                        UserDefaults.standard.set(true, forKey: "notFirstInApp")
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authManager)
            }else{
                PlaceView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authManager)
            }

        }
    }
}
