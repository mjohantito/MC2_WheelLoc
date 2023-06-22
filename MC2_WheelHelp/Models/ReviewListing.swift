//
//  ReviewListing.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 22/06/23.
//

import Foundation
import CloudKit

struct ReviewListing {
    
    
    //review desc
    
    let recordID: CKRecord.ID? // recordID generate by cloudKit
    // let fkuserId: -> binding dari signinView -- foreign key dari userid
    let fkplaces: String // foreign key places
    let rating: Int // to save rating
    let title: String // to save title
    let desc: String // to save description
    let date: Date // when user give review
    // let image
    
    
    //detail information
    let eskalator: String //string untuk spesifik lantai berapa, lokasi berapa, nnti di save dengan separator
    let toilet: String // kalo no index dia switch off
    let lift: String
    let rampt: String
    let aksesmasuk: String
    let tempatparkir: String
    let kursiroda: Bool
    
    
}
