//
//  CloudKit.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 28/06/23.
//

import Foundation

import CloudKit

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

func addRecordHealthFacilitiesToCloudKit(name:String, address:String, category:String, latitude:Double, longitude:Double, img_prefix:[String], img_suffix:[String], fsq_id:String) {
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "HealthFacilities"
    let record = CKRecord(recordType: recordType)

    record["fsq_id"] = fsq_id as CKRecordValue
    record["name"] = name as CKRecordValue
    record["address"] = address as CKRecordValue
    record["category"] = category as CKRecordValue
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





