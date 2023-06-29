//
//  CloudKit.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 28/06/23.
//

import Foundation

import CloudKit

var place: Place!

func addRecordToCloudKit(name:String, address:String, category:String, health_facilities_id:[String], latitude:Double, longitude:Double, img_prefix:[String], img_suffix:[String], fsq_id:String) {
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "Place"
    let record = CKRecord(recordType: recordType)

    record["fsq_id"] = fsq_id as CKRecordValue
    record["name"] = name as CKRecordValue
    record["address"] = address as CKRecordValue
    record["category"] = category as CKRecordValue
    record["health_facilities_id"] = health_facilities_id as CKRecordValue
    record["latitude"] = latitude as CKRecordValue
    record["longitude"] = longitude as CKRecordValue
    record["img_prefix"] = img_prefix as CKRecordValue
    record["img_suffix"] = img_suffix as CKRecordValue

    let database = container.publicCloudDatabase

    database.save(record) { (savedRecord, error) in
        if let error = error {
            // Handle the error
            print("Error saving record: \(error.localizedDescription)")
        } else {
            // Handle the success
            print("Record saved successfully")
        }
    }
}


func addReviewToCloudKit(
    accessibility_rating:Int64, akses_masuk:String, date:Date, description:String, eskalator_lantai:[String], eskalator_lokasi:[String],
    first_name:String, id_place:String, image:[CKAsset], last_name:String, lift_lantai:[String], lift_lokasi:[String], likes:Int64,
    place_name:String, ramp:String, sedia_kursi_roda:String, tempat_prakir:String, title:String, toilet_lantai:[String], toilet_lokasi:[String]) {
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "Review"
    let record = CKRecord(recordType: recordType)
    let reference = CKRecord.Reference(recordID: getPlaceRecordID(fsq_id: fsq_id), action: .none)

    record["accesibility_rating"] = accessibility_rating as CKRecordValue
    record["akses_masuk"] = akses_masuk as CKRecordValue
    record["date"] = date as CKRecordValue
    record["description"] = description as CKRecordValue
    record["eskalator_lantai"] = eskalator_lantai as CKRecordValue
    record["eskalator_lokasi"] = eskalator_lokasi as CKRecordValue
    record["first_name"] = first_name as CKRecordValue
    record["id_place"] = reference
    record["image"] = image.map { CKAsset(fileURL: $0.fileURL ?? URL(fileURLWithPath: "")) }
    record["last_name"] = last_name as CKRecordValue
    record["lift_lantai"] = lift_lantai as CKRecordValue
    record["lift_lokasi"] = lift_lokasi as CKRecordValue
    record["likes"] = likes as CKRecordValue
    record["place_name"] = place_name as CKRecordValue
    record["ramp"] = ramp as CKRecordValue
    record["sedia_kursi_roda"] = sedia_kursi_roda as CKRecordValue
    record["tempat_prakir"] = tempat_prakir as CKRecordValue
    record["title"] = title as CKRecordValue
    record["toilet_lantai"] = toilet_lantai as CKRecordValue
    record["toilet_lokasi"] = toilet_lokasi as CKRecordValue

    let database = container.publicCloudDatabase

    database.save(record) { (savedRecord, error) in
        if let error = error {
            // Handle the error
            print("Error saving record: \(error.localizedDescription)")
        } else {
            // Handle the success
            print("Record saved successfully")
        }
    }
}





