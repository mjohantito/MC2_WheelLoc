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
            print("Record place saved successfully")
        }
    }
}

func addRecordHealthFacilitiesToCloudKit(name:String, address:String, category:String, latitude:Double, longitude:Double, img_prefix:[String], img_suffix:[String], fsq_id:String) {
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "HealthFacility"
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
            print("Record health facilities saved successfully")
        }
    }
}

func addReviewToCloudKit(
    accessibility_rating:Int64, akses_masuk:String, date:Date, description:String, eskalator_lantai:[String], eskalator_lokasi:[String],
    first_name:String, id_place:String, image:[CKAsset], last_name:String, lift_lantai:[String], lift_lokasi:[String], likes:Int64,
    place_name:String, ramp:String, sedia_kursi_roda:String, tempat_prakir:String, title:String, toilet_lantai:[String], toilet_lokasi:[String], email_user:String, recordid_user: String) { //+ recordid_user
    
    print("ke passed: \(id_place) - \(email_user)")
        
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "Review"
    let record = CKRecord(recordType: recordType)
        
    let referenceRecordName = "Place"
    let zoneID = CKRecordZone.default().zoneID
    let id_place = CKRecord.ID(recordName: referenceRecordName, zoneID: zoneID)
    let reference = CKRecord.Reference(recordID: id_place, action: .none)
    // variable simpen recordid_user
    print("ref: \(reference.recordID)")

    record["accesibility_rating"] = accessibility_rating as CKRecordValue
    record["akses_masuk"] = akses_masuk as CKRecordValue
    record["date"] = date as CKRecordValue
    record["description"] = description as CKRecordValue
    record["eskalator_lantai"] = eskalator_lantai as CKRecordValue
    record["eskalator_lokasi"] = eskalator_lokasi as CKRecordValue
    record["first_name"] = first_name as CKRecordValue
    record["id_place"] = reference as CKRecordValue
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
    record["email_user"] = email_user as CKRecordValue
    record["recordid_user"] = recordid_user as CKRecordValue
    
        
    print("after: \(id_place) - \(email_user)")

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


func addUsersToCloudKit(fName:String, lName: String){
    
    let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
    let recordType = "UserListing"
    let record = CKRecord(recordType: recordType)
    
    record["fName"] = fName as CKRecordValue
    record["lName"] = lName as CKRecordValue
    
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
    
    print("\(fName) - \(lName)")
    
}










func removeDuplicateHealthFacilityRecords() {
    let container = CKContainer.default()
    let database = container.publicCloudDatabase
    let recordType = "HealthFacility"

    // Create a query to fetch all HealthFacility records
    let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))

    // Create a dictionary to store unique fsq_id values and their corresponding record IDs
    var uniqueFsqIds: [String: CKRecord.ID] = [:]

    // Perform the query to fetch all records
    database.perform(query, inZoneWith: nil) { (records, error) in
        guard let records = records, error == nil else {
            if let error = error {
                print("Error fetching records: \(error)")
            }
            return
        }

        // Iterate through the fetched records
        for record in records {
            if let fsqId = record["fsq_id"] as? String {
                // Check if the fsq_id is already present in the dictionary
                if let existingRecordID = uniqueFsqIds[fsqId] {
                    // Duplicate record found, delete it from the CloudKit database
                    database.delete(withRecordID: existingRecordID) { (recordID, error) in
                        if let error = error {
                            print("Error deleting record: \(error)")
                        } else {
                            print("Duplicate record deleted with ID: \(recordID?.recordName ?? "")")
                        }
                    }
                } else {
                    // Add the fsq_id to the dictionary with the record ID
                    uniqueFsqIds[fsqId] = record.recordID
                }
            }
        }

        // Print the number of duplicate records found and deleted
        let duplicateCount = records.count - uniqueFsqIds.count
        print("Number of duplicate records found and deleted: \(duplicateCount)")
    }
}






