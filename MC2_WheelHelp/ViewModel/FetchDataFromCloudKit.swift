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

struct UserDetailsResponse {
    var firstName: String
    var lastName: String
    var email: String
}

func fetchUserDetails(appleUserID: String, completion: @escaping (UserDetailsResponse) -> Void) {
    let predicate = NSPredicate(format: "apple_user_id == %@", appleUserID)
    let query = CKQuery(recordType: "UserListing", predicate: predicate)
    let operation = CKQueryOperation(query: query)
    let group = DispatchGroup()
    
    var response = UserDetailsResponse(firstName: "", lastName: "", email: "")
    
    group.enter()
    operation.recordFetchedBlock = { record in
        response.firstName = record["fName"] as? String ?? ""
        response.lastName = record["lName"] as? String ?? ""
        response.email = record["email"] as? String ?? ""
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        group.leave()
    }
    
    // Execute the operation
    CKContainer.default().publicCloudDatabase.add(operation)
    
    // Wait for the operation to complete
    group.notify(queue: .main) {
        completion(response)
    }
}

// fetch data place for CategoryListCardView
func fetchDataPlaceFromCloudKit(recordTypes: [String], category: String = "", name: String = "", completion: @escaping ([KategoriCardView]) -> Void) {
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
            let imgPrefixList = record["img_prefix"] as? [String] ?? []
            let imgSuffixList = record["img_suffix"] as? [String] ?? []
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
            for (prefix, suffix) in zip(imgPrefixList, imgSuffixList) {
                let concatImage = prefix + "original" + suffix
                if let concatImageURL = URL(string: concatImage) {
                    imageURLs.append(concatImageURL)
                    
                } else {
                    print("Failed to create URL for: \(concatImage)")
                }
 
                // Create a CategoryListCardView instance with the fetched data
                let categoryView = KategoriCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
                
                
                // Append the view to the fetchedViews array
                fetchedViews.append(categoryView)
            }
            
            let categoryView = KategoriCardView(imageURLs: imageURLs, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
            
            // Append the view to the fetchedViews array
            fetchedViews.append(categoryView)
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
//func fetchDataPlaceFromCloudKit(recordTypes: [String], category: String = "",name: String = "", completion: @escaping ([KategoriCardView]) -> Void) {
//    var fetchedViews: [KategoriCardView] = []
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
//                let ckRecordIdPlace = record.recordID
//
//                let imageURL: URL
//                if let imageString = concatImageURL {
//                    imageURL = imageString
//                } else {
//                    imageURL = URL(string: "https://example.com/default-image.jpg")!
//                }
//
//                // Create a CategoryListCardView instance with the fetched data
//                let categoryView = KategoriCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
//
//
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


// fetch data place for SearchView
func fetchDataSearchPlaceFromCloudKit(recordTypes: [String],name: String = "", completion: @escaping ([KategoriCardView]) -> Void) {
    var fetchedViews: [KategoriCardView] = []
    let group = DispatchGroup()
    print("name: \(name)")
    
    for recordType in recordTypes {
        group.enter()
        
        
        let predicate = NSPredicate(format: "name BEGINSWITH %@", name)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = CKQueryOperation.maximumResults
        
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
//                let ckRecordIdPlace = record.recordID
//
//                let imageURL: URL
//                if let imageString = concatImageURL {
//                    imageURL = imageString
//                } else {
//                    imageURL = URL(string: "https://example.com/default-image.jpg")!
//                }
//
//                // Create a CategoryListCardView instance with the fetched data
//                let categoryView = KategoriCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
//
//                //check if the category contains the filter
//                if name.contains(name){
//                    // Append the view to the fetchedViews array
//                    fetchedViews.append(categoryView)
//                }
//            }
//        }
        operation.recordFetchedBlock = { record in
            // Extract the necessary data from the CloudKit record
            let imgPrefixList = record["img_prefix"] as? [String] ?? []
            let imgSuffixList = record["img_suffix"] as? [String] ?? []
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
            for (prefix, suffix) in zip(imgPrefixList, imgSuffixList) {
                let concatImage = prefix + "original" + suffix
                if let concatImageURL = URL(string: concatImage) {
                    imageURLs.append(concatImageURL)
                    
                } else {
                    print("Failed to create URL for: \(concatImage)")
                }
            }
            
            let categoryView = KategoriCardView(imageURLs: imageURLs, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String,  latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String], ckRecordIdPlace: ckRecordIdPlace)
            
            // Append the view to the fetchedViews array
            fetchedViews.append(categoryView)
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
    //    print("FETCH DATA JALAN")
    var fetchedViews: [PlaceDetailInformationView] = []
    let group = DispatchGroup()
    
    group.enter()
    
    let predicate = NSPredicate(format: "fsq_id == %@", fsq_id)
    let query = CKQuery(recordType: "Place", predicate: predicate)
    
    let operation = CKQueryOperation(query: query)
    operation.resultsLimit = CKQueryOperation.maximumResults
    
    operation.recordFetchedBlock = { record in
        // Extract the necessary data from the CloudKit record
        let imgPrefixList = record["img_prefix"] as? [String] ?? []
        let imgSuffixList = record["img_suffix"] as? [String] ?? []
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
        for (prefix, suffix) in zip(imgPrefixList, imgSuffixList) {
            let concatImage = prefix + "original" + suffix
            if let concatImageURL = URL(string: concatImage) {
                imageURLs.append(concatImageURL)
                
            } else {
                print("Failed to create URL for: \(concatImage)")
            }
        }
        
        //        print("INI: \(imageURLs)")
        
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
//                let health_facilities_id = record["health_facilities_id"]
                let latitude = record["latitude"]
                let longitude = record["longitude"]
                let name = record["name"] as? String ?? ""
//                let rating = record["rating"] as? Double ?? 0.0
//                let jumlah_review = record["jumlah_review"] as? Int ?? 0
                
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

struct ReviewResponse {
    let accessibilityRating: Double
    let entrance: String
    let date: Date
    let description: String
    let escalatorFloor: [String]
    let escalatorLocation: [String]
    let firstName: String
    let placeId: CKRecord.Reference
    let lastName: String
    let liftFloor: [String]
    let liftLocation: [String]
    let likes: Int64
    let placeName: String
    let ramp: String
    let wheelchairAvailable: String
    let parking: String
    let title: String
    let toiletFloor: [String]
    let toiletLocation: [String]
    let ckRecordIdReview: CKRecord.ID
    //    let image: [CKAsset]
    var isLiked: Bool
    
}

func fetchDataPlaceReviewFromCloudkit(recordTypes: [String], placeId: CKRecord.ID, userId: String = "", likedReviewIDs: [String], completion: @escaping ([ReviewResponse]?, ReviewResponse?) -> Void) {
    //    print("FETCH DATA PLACE REVIEW")
    
    group.enter()
    operation.recordFetchedBlock = { record in
        response.firstName = record["fName"] as? String ?? ""
        response.lastName = record["lName"] as? String ?? ""
        response.email = record["email"] as? String ?? ""
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        group.leave()
    }
    
    // Execute the operation
    CKContainer.default().publicCloudDatabase.add(operation)
    
    // Wait for the operation to complete
    group.notify(queue: .main) {
        completion(response)
    }
}
    
struct ReviewResponse {
    let accessibilityRating: Double
    let entrance: String
    let date: Date
    let description: String
    let escalatorFloor: [String]
    let escalatorLocation: [String]
    let firstName: String
    let placeId: CKRecord.Reference
    let lastName: String
    let liftFloor: [String]
    let liftLocation: [String]
    let likes: Int64
    let placeName: String
    let ramp: String
    let wheelchairAvailable: String
    let parking: String
    let title: String
    let toiletFloor: [String]
    let toiletLocation: [String]
    let ckRecordIdReview: CKRecord.ID
    //    let image: [CKAsset]
    var isLiked: Bool
    
}

func fetchDataPlaceReviewFromCloudkit(recordTypes: [String], placeId: CKRecord.ID, userId: String = "", likedReviewIDs: [String], completion: @escaping ([ReviewResponse]?, ReviewResponse?) -> Void) {
    //    print("FETCH DATA PLACE REVIEW")
    
    let placeReference = CKRecord.Reference(recordID: placeId, action: .none)
    let predicate = NSPredicate(format: "id_place == %@", placeReference)
    let query = CKQuery(recordType: "Review", predicate: predicate)
    let operation = CKQueryOperation(query: query)
    let group = DispatchGroup()
    var reviewResponses: [ReviewResponse] = []
    var mostLikedReviewResponse: ReviewResponse?
    
    group.enter()
    operation.recordFetchedBlock = { record in
        let accessibilityRating = record["accesibility_rating"] as? Double ?? 0.0
        let entrance = record["akses_masuk"] as! String
        let date = record["date"] as! Date
        let description = record["description"] as! String
        let escalatorFloor = record["eskalator_lantai"] as! [String]
        let escalatorLocation = record["eskalator_lokasi"] as! [String]
        let firstName = record["first_name"] as! String
        let placeId = record["id_place"] as! CKRecord.Reference
        let lastName = record["last_name"] as! String
        let liftFloor = record["lift_lantai"] as! [String]
        let liftLocation = record["lift_lokasi"] as! [String]
        let likes = record["likes"] as! Int64
        let placeName = record["place_name"] as! String
        let ramp = record["ramp"] as! String
        let wheelchairAvailable = record["sedia_kursi_roda"] as! String
        let parking = record["tempat_parkir"] as? String
        let toiletFloor = record["toilet_lantai"] as! [String]
        let toiletLocation = record["toilet_lokasi"] as! [String]
        let title = record["title"] as! String
//        let image = record["image"] as! [CKAsset]
//
//        var isLiked = false
//        let ckRecordIdReview = record.recordID
//        let ckRecordNameReview = record.recordID.recordName
        
        let response = ReviewResponse(
            accessibilityRating: accessibilityRating,
            entrance: entrance,
            date: date,
            description: description,
            escalatorFloor: escalatorFloor,
            escalatorLocation: escalatorLocation,
            firstName: firstName,
            placeId: placeId,
            lastName: lastName,
            liftFloor: liftFloor,
            liftLocation: liftLocation,
            likes: likes,
            placeName: placeName,
            ramp: ramp,
            wheelchairAvailable: wheelchairAvailable,
            parking: parking ?? "",
            title: title,
            toiletFloor: toiletFloor,
            toiletLocation: toiletLocation,
            ckRecordIdReview: record.recordID,
            isLiked: likedReviewIDs.contains(record.recordID.recordName)
            //            image: image,
        )
        
        reviewResponses.append(response)
        
        if mostLikedReviewResponse == nil || likes > mostLikedReviewResponse?.likes ?? 0 {
            mostLikedReviewResponse = response
        }
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        group.leave()
    }
    
    CKContainer.default().publicCloudDatabase.add(operation)
    
    group.notify(queue: .main) {
        completion(reviewResponses, mostLikedReviewResponse)
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
    let response = PlaceResponse(address: "default", category: "default", count_review: 1, fsq_id: "default", health_facilities_id: ["default"], img_prefix: ["default"], img_suffix: ["default"], latitude: 1.0, longitude: 1.0, name: "default", rating: 1.0, ckRecordIdPlace: CKRecord.ID(recordName: "default"))
    
    return response
}

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
//=======
//
//    func fetchDataPlaceRecommendationFromCloudKit(recordTypes: [String], category: String, completion: @escaping ([KategoriCardView]) -> Void) {
//        var fetchedViews: [KategoriCardView] = []
//        let group = DispatchGroup()
//
//        for recordType in recordTypes {
//            group.enter()
//
//            let predicate = NSPredicate(format: "category == %@", category)
//            let query = CKQuery(recordType: recordType, predicate: predicate)
//
//            let operation = CKQueryOperation(query: query)
//            operation.resultsLimit = CKQueryOperation.maximumResults
//
//            operation.recordFetchedBlock = { record in
//                // Extract the necessary data from the CloudKit record
//                let imgPrefixList = record["img_prefix"] as? [String]
//                let imgPrefix = imgPrefixList?.first
//                let imgSuffixList = record["img_suffix"] as? [String]
//                let imgSuffix = imgSuffixList?.first
//
//                if let imgPrefix = imgPrefix,
//                   let imgSuffix = imgSuffix {
//                    let concatImage = "\(imgPrefix)100x100\(imgSuffix)"
//                    let concatImageURL = URL(string: concatImage)
//
//                    let address = record["address"]
//                    let category = record["category"] as? String ?? ""
//                    let fsq_id = record["fsq_id"]
//                    let health_facilites_id = record["health_facilities_id"]
//                    let latitude = record["latitude"]
//                    let longitude = record["longitude"]
//                    let name = record["name"] as? String ?? ""
//                    let rating = record["rating"] as? Double ?? 0.0
//                    let jumlah_review = record["jumlah_review"] as? Int ?? 0
//
//                    if rating > 3.5 { // Filter places with rating > 3.5
//                        let imageURL: URL
//                        if let imageString = concatImageURL {
//                            imageURL = imageString
//                        } else {
//                            imageURL = URL(string: "https://example.com/default-image.jpg")!
//                        }
//
//                        // Create a CategoryListCardView instance with the fetched data
//                        let categoryView = KategoriCardView(imageURL: imageURL, placeName: name, address: address as! String, kategori: category, rating: rating, jumlahUlasan: jumlah_review, fsq_id: fsq_id as! String, latitude: latitude as! Double, longitude: longitude as! Double, health_facilities_id: health_facilites_id as! [String])
//                        // Append the view to the fetchedViews array
//                        fetchedViews.append(categoryView)
//                    }
//>>>>>>> angelo_rombakHomePage
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

    
    group.notify(queue: DispatchQueue.main) {
        completion(fetchedViews)
    }
}

func checkIfUserLikesReview(userId: String, completion: @escaping ([String]) -> Void) {
    
    let predicate = NSPredicate(format: "user_id == %@", userId)
    let query = CKQuery(recordType: "Like", predicate: predicate)
    let operation = CKQueryOperation(query: query)
    var likedReviewIDs: [String] = []
    
    operation.recordFetchedBlock = { record in
        if let reviewID = record["review_id"] as? String {
            likedReviewIDs.append(reviewID)
        }
    }
    
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        completion(likedReviewIDs)
    }
    
    CKContainer.default().publicCloudDatabase.add(operation)
}

struct FacilityFromReviewResponse {
    var isLiftAvailable: Bool
    var isEscalatorAvailable: Bool
    var isRampAvailable: Bool
    var isToiletAvailable: Bool
    var isEntranceAvailable: Bool
    var isParkingAvailable: Bool
    var isWheelchairAvailable: Bool
}

func isFieldAvailable(_ fieldValue: Any?) -> Bool {
    if let arrayValue = fieldValue as? [Any], !arrayValue.isEmpty {
        return true
    }
    return false
}

func fetchDataFacilityFromMostLikedReview(reviewId: CKRecord.ID, completion: @escaping (FacilityFromReviewResponse?) -> Void) {
    //    print("FETCH DATA FACILITY FROM MOST LIKED REVIEW")
    
    let predicate = NSPredicate(format: "recordID == %@", reviewId)
    let query = CKQuery(recordType: "Review", predicate: predicate)
    let operation = CKQueryOperation(query: query)
    let group = DispatchGroup()
    
    var response = FacilityFromReviewResponse(isLiftAvailable: false, isEscalatorAvailable: false, isRampAvailable: false, isToiletAvailable: false, isEntranceAvailable: false, isParkingAvailable: false, isWheelchairAvailable: false)
    
    group.enter()
    operation.recordFetchedBlock = { record in
        response.isLiftAvailable = isFieldAvailable(record["lift_lantai"])
        response.isEscalatorAvailable = isFieldAvailable(record["eskalator_lantai"])
        response.isRampAvailable = isFieldAvailable(record["ramp"])
        response.isToiletAvailable = isFieldAvailable(record["toilet_lantai"])
        response.isEntranceAvailable = isFieldAvailable(record["akses_masuk"])
        response.isParkingAvailable = isFieldAvailable(record["tempat_parkir"])
        response.isWheelchairAvailable = isFieldAvailable(record["sedia_kursi_roda"])
        //        if let liftAvailable = record["lift_lantai"] as? [String], !liftAvailable.isEmpty {
        //            response.isLiftAvailable = true
        //        } else {
        //            response.isLiftAvailable = false
        //        }
        //
        //        if let escalatorAvailable = record["eskalator_lantai"] as? [String], !escalatorAvailable.isEmpty {
        //            response.isEscalatorAvailable = true
        //        } else {
        //            response.isEscalatorAvailable = false
        //        }
    }
    operation.queryCompletionBlock = { cursor, error in
        if let error = error {
            print("Error fetching data from CloudKit: \(error.localizedDescription)")
        }
        group.leave()
    }
    
    // Execute the operation
    CKContainer.default().publicCloudDatabase.add(operation)
    
    // Wait for the operation to complete
    group.notify(queue: .main) {
        completion(response)
    }
}


