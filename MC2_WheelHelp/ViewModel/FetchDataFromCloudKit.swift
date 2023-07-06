//
//  fetchDataPlaceFromCloudKit.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 30/06/23.
//

import Foundation
import CloudKit

let container = CKContainer(identifier: "iCloud.com.ada.MC2-WheelHelp-Putri")
let database = container.publicCloudDatabase

//func fetchDataPlaceFromCloudKit(recordTypes: [String], completion: @escaping ([CategoryListCardView]) -> Void) {
//    var fetchedViews: [CategoryListCardView] = []
//    let group = DispatchGroup()
//
//    for recordType in recordTypes {
//        group.enter()
//
//        let predicate = NSPredicate(value: true)
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
//                // Create a CategoryListCardView instance with the fetched data
//                let categoryView = CategoryListCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review)
//                // Append the view to the fetchedViews array
//                fetchedViews.append(categoryView)
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
//        completion(fetchedViews)
//    }
//}

func fetchDataPlaceFromCloudKit(recordTypes: [String], category: String, completion: @escaping ([CategoryListCardView]) -> Void) {
    var fetchedViews: [CategoryListCardView] = []
    let group = DispatchGroup()
    print("category: \(category)")
    
    for recordType in recordTypes {
        group.enter()
        
        let predicate = NSPredicate(format: "category == %@", category)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = CKQueryOperation.maximumResults
        
        operation.recordFetchedBlock = { record in
            // Extract the necessary data from the CloudKit record
            let imgPrefixList = record["img_prefix"] as? [String]
            let imgPrefix = imgPrefixList?.first
            let imgSuffixList = record["img_suffix"] as? [String]
            let imgSuffix = imgSuffixList?.first

            if let imgPrefix = imgPrefix,
               let imgSuffix = imgSuffix {
                let concatImage = "\(imgPrefix)100x100\(imgSuffix)"
                let concatImageURL = URL(string: concatImage)
                
                let address = record["address"]
                let category = record["category"] as? String ?? ""
                let fsq_id = record["fsq_id"]
                let health_facilites_id = record["health_facilities_id"]
                let latitude = record["latitude"]
                let longitude = record["longitude"]
                let name = record["name"] as? String ?? ""
                let rating = record["rating"] as? Double ?? 0.0
                let jumlah_review = record["jumlah_review"] as? Int ?? 0

                let imageURL: URL
                if let imageString = concatImageURL {
                    imageURL = imageString
                } else {
                    imageURL = URL(string: "https://example.com/default-image.jpg")!
                }
                
                // Create a CategoryListCardView instance with the fetched data
                let categoryView = CategoryListCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String])
                
                
                // Append the view to the fetchedViews array
                fetchedViews.append(categoryView)
            }
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                print("Error fetching data from CloudKit: \(error.localizedDescription)")
            }
            
            group.leave()
        }
        
        database.add(operation)
    }
    
    group.notify(queue: DispatchQueue.main) {
        completion(fetchedViews)
    }
}

func fetchDataFromCloudKit(fsq_id: String, completion: @escaping ([PlaceDetailInformationView]) -> Void) {
    var fetchedViews: [PlaceDetailInformationView] = []
    let group = DispatchGroup()
    
    group.enter()
    
    let predicate = NSPredicate(format: "fsq_id == %@", fsq_id)
    let query = CKQuery(recordType: "Place", predicate: predicate)
    
    let operation = CKQueryOperation(query: query)
    operation.resultsLimit = CKQueryOperation.maximumResults
    
    operation.recordFetchedBlock = { record in
        // Extract the necessary data from the CloudKit record
        let imgPrefixList = record["img_prefix"] as? [String]
        let imgSuffixList = record["img_suffix"] as? [String]
        let address = record["address"]
        let category = record["category"] as? String ?? ""
        let fsq_id = record["fsq_id"]
        let health_facilites_id = record["health_facilities_id"]
        let latitude = record["latitude"]
        let longitude = record["longitude"]
        let name = record["name"] as? String ?? ""
        let rating = record["rating"] as? Double ?? 0.0
        let jumlah_review = record["jumlah_review"] as? Int ?? 0

        var imageURLs: [URL] = []
        if let imgPrefixList = imgPrefixList,
           let imgSuffixList = imgSuffixList {
            for (prefix, suffix) in zip(imgPrefixList, imgSuffixList) {
                let concatImage = "\(prefix)original\(suffix)"
                if let concatImageURL = URL(string: concatImage) {
                    imageURLs.append(concatImageURL)
                }
            }
        }
        
//        print("ini yg ke passed: \(imageURLs.count)")

        // Create a PlaceDetailInformationView instance with the fetched data
        let placeDetailInformationView = PlaceDetailInformationView(imageURLs: imageURLs, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String])
        // Append the view to the fetchedViews array
        fetchedViews.append(placeDetailInformationView)
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        
        group.leave()
    }
    
    database.add(operation)
    
    group.notify(queue: DispatchQueue.main) {
        completion(fetchedViews)
    }
}

func fetchDataHealthFacilityFromCloudKit(recordTypes: [String], fsqIDs: [String], completion: @escaping ([NearbyHealthFacilitiesCardView]) -> Void) {
    print(fsqIDs)
    
    var fetchedViews: [NearbyHealthFacilitiesCardView] = []
    var fetchedFSQIDs: Set<String> = [] // Keep track of fetched fsq_ids
    let group = DispatchGroup()

    for fsqID in fsqIDs {
        group.enter()

        let predicate = NSPredicate(format: "fsq_id == %@", fsqID)
        let query = CKQuery(recordType: recordTypes[0], predicate: predicate)
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1

        operation.recordFetchedBlock = { record in
            // Extract the necessary data from the CloudKit record
            let imgPrefixList = record["img_prefix"] as? [String]
            let imgPrefix = imgPrefixList?.first
            let imgSuffixList = record["img_suffix"] as? [String]
            let imgSuffix = imgSuffixList?.first

            if let imgPrefix = imgPrefix, let imgSuffix = imgSuffix {
                let concatImage = "\(imgPrefix)100x100\(imgSuffix)"
                let concatImageURL = URL(string: concatImage)

                let address = record["address"]
                let category = record["category"] as? String ?? ""
                let fsq_id = record["fsq_id"]
                let health_facilities_id = record["health_facilities_id"]
                let latitude = record["latitude"]
                let longitude = record["longitude"]
                let name = record["name"] as? String ?? ""
                let rating = record["rating"] as? Double ?? 0.0
                let jumlah_review = record["jumlah_review"] as? Int ?? 0

                let imageURL: URL
                if let imageString = concatImageURL {
                    imageURL = imageString
                } else {
                    imageURL = URL(string: "https://example.com/default-image.jpg")!
                }

                // Create a NearbyHealthFacilitiesCardView instance with the fetched data
                let facilityView = NearbyHealthFacilitiesCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double)

                DispatchQueue.main.async {
                    // Append the view to the fetchedViews array
                    fetchedViews.append(facilityView)
                    // Add fetched fsq_id to the fetchedFSQIDs set
                    fetchedFSQIDs.insert(fsq_id as! String)
                }
            }
        }

        operation.queryCompletionBlock = { cursor, error in
            if let error = error {
                print("Error fetching data from CloudKit: \(error.localizedDescription)")
            }

            group.leave()
        }

        database.add(operation)
    }

    group.notify(queue: DispatchQueue.main) {
        completion(fetchedViews)
    }
}

func fetchDataUserReviewFromCloudkit(recordTypes: [String], userId: String, completion: @escaping ([ProfileReviewCardView]) -> Void) {
    var fetchedViews: [ProfileReviewCardView] = []
    let group = DispatchGroup()
    
    //fetch nama user dari userId + image + likes
    
    let predicate = NSPredicate(format: "userId == %@", userId)
    let query = CKQuery(recordType: recordTypes[0], predicate: predicate)
    let operation = CKQueryOperation(query: query)
    operation.resultsLimit = CKQueryOperation.maximumResults
    
    operation.recordFetchedBlock = { record in
        let accessibility_rating = record["accesibility_rating"] as? Double ?? 0.0
        let date = record["date"] as! String
        let description = record["description"] as! String
        let first_name = record["first_name"] as! String
        let placeReference = record["id_place"]
        // image
        let last_name = record["last_name"]
        let likes = record["likes"]
        let place_name = record["place_name"]
        let title = record["title"] as! String
        let email_user = record["email_user"]
        
        let ProfileReviewView = ProfileReviewCardView(userNameReview: first_name, dateReview: date, ratingReview: accessibility_rating, titleReview: title, descriptionReview: description)
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        
        group.leave()
    }
    
    database.add(operation)
    
    group.notify(queue: DispatchQueue.main) {
        completion(fetchedViews)
    }
}


