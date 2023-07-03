//
//  fetchDataFromCloudKit.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 01/07/23.
//

import Foundation
import CloudKit


//func fetchDataFromCloudKit(recordTypes: [String], category: String, fsq_id: String, completion: @escaping ([CategoryListCardView]) -> Void) {
//    var fetchedViews: [PlaceDetailInformationView] = []
//    let group = DispatchGroup()
//    print("category: \(category)")
//
//    for recordType in recordTypes {
//        group.enter()
//
//        let predicate = NSPredicate(format: "category == %@", category)
//        let query = CKQuery(recordType: recordType, predicate: predicate)
//
//        let operation = CKQueryOperation(query: query)
//        operation.resultsLimit = CKQueryOperation.maximumResults
//
//        operation.recordFetchedBlock = { record in
//            // Extract the necessary data from the CloudKit record
//            let imgPrefixList = record["img_prefix"] as? [String]
//            let imgPrefix = imgPrefixList?.first
//            let imgSuffixList = record["img_suffix"] as? [String]
//            let imgSuffix = imgSuffixList?.first
//
//            if let imgPrefix = imgPrefix,
//               let imgSuffix = imgSuffix {
//                let concatImage = "\(imgPrefix)100x100\(imgSuffix)"
//                let concatImageURL = URL(string: concatImage)
//
//                let address = record["address"]
//                let category = record["category"] as? String ?? ""
//                let fsq_id = record["fsq_id"]
//                let health_facilites_id = record["health_facilities_id"]
//                let latitude = record["latitude"]
//                let longitude = record["longitude"]
//                let name = record["name"] as? String ?? ""
//                let rating = record["rating"] as? Double ?? 0.0
//                let jumlah_review = record["jumlah_review"] as? Int ?? 0
//
//                let imageURL: URL
//                if let imageString = concatImageURL {
//                    imageURL = imageString
//                } else {
//                    imageURL = URL(string: "https://example.com/default-image.jpg")!
//                }
//
//                print("MASUK")
//
//                // Create a CategoryListCardView instance with the fetched data
//                let placeDetailInformationView = PlaceDetailInformationView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double)
//                // Append the view to the fetchedViews array
//                fetchedViews.append(placeDetailInformationView)
//            }
//        }
//
//        operation.queryCompletionBlock = { cursor, error in
//            if let error = error {
//                print("Error fetching data from CloudKit: \(error.localizedDescription)")
//            }
//
//            group.leave()
//        }
//
//        database.add(operation)
//    }
//
//    group.notify(queue: DispatchQueue.main) {
////        completion(fetchedViews)
//    }
//}

//func fetchDataFromCloudKit(fsq_id: String, completion: @escaping ([PlaceDetailInformationView]) -> Void) {
//    var fetchedViews: [PlaceDetailInformationView] = []
//    let group = DispatchGroup()
//
//    group.enter()
//
//    let predicate = NSPredicate(format: "fsq_id == %@", fsq_id)
//    let query = CKQuery(recordType: "Place", predicate: predicate)
//
//    let operation = CKQueryOperation(query: query)
//    operation.resultsLimit = CKQueryOperation.maximumResults
//
//    operation.recordFetchedBlock = { record in
//        // Extract the necessary data from the CloudKit record
//        let imgPrefixList = record["img_prefix"] as? [String]
//        let imgSuffixList = record["img_suffix"] as? [String]
//        let address = record["address"]
//        let category = record["category"] as? String ?? ""
//        let fsq_id = record["fsq_id"]
//        let health_facilites_id = record["health_facilities_id"]
//        let latitude = record["latitude"]
//        let longitude = record["longitude"]
//        let name = record["name"] as? String ?? ""
//        let rating = record["rating"] as? Double ?? 0.0
//        let jumlah_review = record["jumlah_review"] as? Int ?? 0
//
//        var imageURLs: [URL] = []
//        if let imgPrefixList = imgPrefixList,
//           let imgSuffixList = imgSuffixList {
//            for (prefix, suffix) in zip(imgPrefixList, imgSuffixList) {
//                let concatImage = "\(prefix)original\(suffix)"
//                if let concatImageURL = URL(string: concatImage) {
//                    imageURLs.append(concatImageURL)
//                }
//            }
//        }
//
//        print("ini yg ke passed: \(imageURLs.count)")
//
//        // Create a PlaceDetailInformationView instance with the fetched data
//        let placeDetailInformationView = PlaceDetailInformationView(imageURLs: imageURLs, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String])
//        // Append the view to the fetchedViews array
//        fetchedViews.append(placeDetailInformationView)
//    }
//
//    operation.queryCompletionBlock = { cursor, error in
//        if let error = error {
//            print("Error fetching data from CloudKit: \(error.localizedDescription)")
//        }
//
//        group.leave()
//    }
//
//    database.add(operation)
//
//    group.notify(queue: DispatchQueue.main) {
//        completion(fetchedViews)
//    }
//}


