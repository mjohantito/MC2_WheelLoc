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
    let isEskalator: Bool //toogle eskalator
    let flEskalator: String //floor eskalator
    let locEskalator: String //lokasi eskalator
    
    let isToilet: Bool //toogle toilet
    let flToilet: String //floor toilet
    let locToilet: String //lokasi toilet
    
    let isLift: Bool //toogle toilet
    let flLift: String //floor toilet
    let locLift: String //lokasi toilet
    
    let isAksesMasuk: Bool //toogle aksesmasuk
    let locAksesMasuk: String //lokasi aksesmasuk
    
    let isTempatParkir: Bool //toogle tempatparkir
    let locTempatParkir: String //lokasi tempatparkir
    
    let isKursiRoda: Bool // toogle kursi roda
    let locKursiRoda: String // lokasi peminjaman kursi roda
    
    
    init(recordID: CKRecord.ID? = nil, fkPlaceId: String, rating: Double, title: String, desc: String, date: Date, image: String, likes: Int, isEskalator: Bool, flEskalator: String, locEskalator: String, isToilet: Bool, flToilet: String, locToilet: String, isLift: Bool, flLift: String, locLift: String, isAksesMasuk: Bool, locAksesMasuk: String, isTempatParkir: Bool, locTempatParkir: String, isKursiRoda: Bool, locKursiRoda: String) {
        self.recordID = recordID
        // self.fkUserId = fkUserId
        self.fkPlaceId = fkPlaceId
        self.rating = rating
        self.title = title
        self.desc = desc
        self.date = date
        self.image = image
        self.likes = likes
        self.isEskalator = isEskalator
        self.flEskalator = flEskalator
        self.locEskalator = locEskalator
        self.isToilet = isToilet
        self.flToilet = flToilet
        self.locToilet = locToilet
        self.isLift = isLift
        self.flLift = flLift
        self.locLift = locLift
        self.isAksesMasuk = isAksesMasuk
        self.locAksesMasuk = locAksesMasuk
        self.isTempatParkir = isTempatParkir
        self.locTempatParkir = locTempatParkir
        self.isKursiRoda = isKursiRoda
        self.locKursiRoda = locKursiRoda
    }
    
    
}
