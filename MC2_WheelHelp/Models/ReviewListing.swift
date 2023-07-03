//
//  ReviewListing.swift
//  MC2_WheelHelp
//
//  Created by Manuel Johan Tito on 22/06/23.
//

import Foundation
import CloudKit

struct ReviewListing {
    
//    @Binding var userId: String
    
    
    //review desc
    var recordID: CKRecord.ID? // recordID generate by cloudKit
    // let fkUserId: -> binding dari signinView -- foreign key dari userid
    let fkPlaceId: String // foreign key places
    let rating: Double // to save rating
    let title: String // to save title
    let desc: String // to save description
    let date: Date // when user give review
    let image: String // sementara pake url dulu yak, ga tau nnti di simpen dimana dulu .. wkwkwk
    let likes: Int // itung thumbs up di review
    
    
    
    //detail information
    let isEskalator: Int //toogle eskalator, di CK ga ada bool
//    let flEskalator: String //floor eskalator
//    let locEskalator: String //lokasi eskalator
    let detailEskalator: String
    
//    let isToilet: Bool //toogle toilet
//    let flToilet: String //floor toilet
//    let locToilet: String //lokasi toilet
//
//    let isLift: Bool //toogle toilet
//    let flLift: String //floor toilet
//    let locLift: String //lokasi toilet
//
//    let isEntry: Bool //toogle aksesmasuk
//    let locEntry: String //lokasi aksesmasuk
//
//    let isParkingSlot: Bool //toogle tempatparkir
//    let locParkingSlot: String //lokasi tempatparkir
//
//    let isWheelChair: Bool // toogle kursi roda
//    let locWheelChair: String // lokasi peminjaman kursi roda
    
    init(recordID: CKRecord.ID? = nil, fkPlaceId: String, rating: Double, title: String, desc: String, date: Date, image: String, likes: Int, isEskalator: Int, detailEskalator: String) {
        self.recordID = recordID
        self.fkPlaceId = fkPlaceId
        self.rating = rating
        self.title = title
        self.desc = desc
        self.date = date
        self.image = image
        self.likes = likes
        self.isEskalator = isEskalator
        self.detailEskalator = detailEskalator
    }
    
    
}
