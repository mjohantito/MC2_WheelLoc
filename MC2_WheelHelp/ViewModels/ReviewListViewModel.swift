//
//  ReviewListViewModel.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 23/06/23.
//

import Foundation
import CloudKit

class ItemListViewModel: ObservableObject {
    
    private var database: CKDatabase
    private var container: CKContainer
    
    init(container: CKContainer) {
        self.database = self.container.publicCloudDatabase // 9:53 beggining cloudkit
        self.container = container
    }
    
    // func saveitem
}
