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

// fetch data place for CategoryListCardView
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
                let ckRecordIdPlace = record.recordID

                let imageURL: URL
                if let imageString = concatImageURL {
                    imageURL = imageString
                } else {
                    imageURL = URL(string: "https://example.com/default-image.jpg")!
                }
                
                // Create a CategoryListCardView instance with the fetched data
                let categoryView = CategoryListCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
                
                
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

// fetch data place detail information
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
        let ckRecordIdPlace = record.recordID

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
        let placeDetailInformationView = PlaceDetailInformationView(imageURLs: imageURLs, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
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

// fetch data health facilities related to the place
func fetchDataHealthFacilityFromCloudKit(recordTypes: [String], fsqIDs: [String], completion: @escaping ([NearbyHealthFacilitiesCardView]) -> Void) {
//    print(fsqIDs)
    
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


// fetch data review related to the place
func fetchDataPlaceReviewFromCloudkit(recordTypes: [String], placeId: CKRecord.ID, completion: @escaping ([ReviewCardView]) -> Void) {
    var fetchedViews: [ReviewCardView] = []
    let group = DispatchGroup()
    
    group.enter()
    let placeReference = CKRecord.Reference(recordID: placeId, action: .none)
    let predicate = NSPredicate(format: "id_place == %@", placeReference)
    //    let predicate = NSPredicate(format: "id_place == %@", placeId.recordName)
    let query = CKQuery(recordType: "Review", predicate: predicate)
    let operation = CKQueryOperation(query: query)
    //    operation.resultsLimit = CKQueryOperation.maximumResults
    
    operation.recordFetchedBlock = { record in
        print("PASSYA")
        let accessibilityRating = record["accesibility_rating"] as? Double ?? 0.0
        let date = record["date"] as! Date
        let description = record["description"] as! String
        let first_name = record["first_name"] as! String
        let placeId = record["id_place"]
        let last_name = record["last_name"] as! String
        let likes = record["likes"]
        let title = record["title"] as! String
        let ckRecordIdReview = record.recordID
        
        
        let image = record["image"] as? CKAsset
        let imageData = NSData(contentsOf: image?.fileURL ?? URL(fileURLWithPath: ""))
        
        let reviewView = ReviewCardView(userFName: first_name, userLName: last_name, dateReview: date, titleReview: title, descriptionReview: description, likesReview: likes as! Int, ratingReview: accessibilityRating, ckRecordIdReview: ckRecordIdReview , ckRecordIDPlace: placeId as! CKRecord.Reference)
        
        fetchedViews.append(reviewView)
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


    // Execute the operation
    CKContainer.default().publicCloudDatabase.add(operation)
    
    // Wait for the operation to complete
    group.notify(queue: .main) {
        completion(fetchedViews) // Pass the fetched views to the completion handler
    }
}


struct PlaceResponse {
    let address: String
    let category: String
    let count_review: Int64
    let fsq_id: String
    let health_facilities_id: [String]
    let img_prefix: [String]
    let img_suffix: [String]
    let latitude: Double
    let longitude: Double
    let name: String
    let rating: Double
    let ckRecordIdPlace: CKRecord.ID
}


func fetchDummyDataPlaceFromCloudKit() -> PlaceResponse {
    let group = DispatchGroup()
    let response = PlaceResponse(address: "default", category: "default", count_review: 1, fsq_id: "default", health_facilities_id: ["default"], img_prefix: ["default"], img_suffix: ["default"], latitude: 1.0, longitude: 1.0, name: "default", rating: 1.0, ckRecordIdPlace: CKRecord.ID(recordName: "default"))
    
    return response
    
    
    //         group.leave()
}

//     database.add(operation)
func fetchDataPlaceRecommendationFromCloudKit(recordTypes: [String], category: String, completion: @escaping ([KategoriCardView]) -> Void) {
    var fetchedViews: [KategoriCardView] = []
    let group = DispatchGroup()
    
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
                let ckRecordIdPlace = record.recordID
                
                if rating > 3.5 { // Filter places with rating > 3.5
                    let imageURL: URL
                    if let imageString = concatImageURL {
                        imageURL = imageString
                    } else {
                        imageURL = URL(string: "https://example.com/default-image.jpg")!
                    }
                    
                    // Create a CategoryListCardView instance with the fetched data
                    let categoryView = KategoriCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
                    // Append the view to the fetchedViews array
                    fetchedViews.append(categoryView)
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
    
