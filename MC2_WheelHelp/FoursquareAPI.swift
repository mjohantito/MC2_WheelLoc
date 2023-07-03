//
//  FoursquareAPI.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 21/06/23.
//

import Foundation
import SwiftUI

class FoursquareAPI: ObservableObject {
    
    @Published var placeResults = [Place]()
    @Published var placeResults2 = [Place]()
    let authKey = "fsq3VGSxuPFXJFATJcJyeCh8BgVdQJ+b2hPrXIYtvPN4tH0="
    
    //MARK: Calling places and its images from Foursquare API
    func fetchPlacesandImages() {
        var fetchedPlaces = Set<String>()
        
        let headers = [
            "Accept": "application/json",
            "Authorization": authKey
        ]
        let baseURL = URL(string: "https://api.foursquare.com/v3/places/search")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "near", value: "Surabaya"),
            URLQueryItem(name: "categories", value: "17115"),
            URLQueryItem(name: "limit", value: "30")
        ]
        let url = baseURL.appending(queryItems: queryItems)
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { [weak self] (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                var resultsJSON = [Place]() // Store the final results
                let group = DispatchGroup() // Create a group for synchronizing
                
                for result in jsonData.results {
                    let fsq_id = result.fsq_id
                    let categoriesName = result.categories.first?.name ?? ""
                    let name = result.name
                    let latitude = result.geocodes.main.latitude
                    let longitude = result.geocodes.main.longitude
                    let formatted_address = result.location.formatted_address
                    
                    if !fetchedPlaces.contains(fsq_id) {
                        fetchedPlaces.insert(fsq_id)
                        
                        var place = Place(fsq_id: fsq_id, categories_name: categoriesName, name: name, latitude: latitude, longitude: longitude, formatted_address: formatted_address, imagesData: nil, healthFacilities: nil)
                        
                        group.enter()
                        self?.fetchImagesPlaces(fsq_id: fsq_id) { imagesData in
                            place.imagesData = imagesData
                            group.leave()
                        }
                        
                        group.notify(queue: .main) {
                            resultsJSON.append(place) // Append place objects here
                            if resultsJSON.count == fetchedPlaces.count {
                                self?.placeResults = resultsJSON
                                do {
                                    let encoder = JSONEncoder()
                                    encoder.outputFormatting = .prettyPrinted
                                    
                                    let jsonDataNew = try encoder.encode(resultsJSON)
                                    if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
                                        print(jsonString) // This line just for checking if the place already fetched, you can comment it
                                    }
                                } catch {
                                    print("Error encoding JSON: \(error)")
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        dataTask.resume()
    }
    
    //MARK: Calling only the images of a certain place from Foursquare API
    func fetchImagesPlaces(fsq_id: String, completion: @escaping ([Images]?) -> Void) -> Void {
        
        let headers = [
            "Accept": "application/json",
            "Authorization": authKey
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.foursquare.com/v3/places/\(fsq_id)/photos?limit=5")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let imagesData = try JSONDecoder().decode([Images].self, from: data)
                completion(imagesData)
                // Print the JSON result
                //                let encoder = JSONEncoder()
                //                encoder.outputFormatting = .prettyPrinted
                //
                //                let jsonData = try encoder.encode(imagesData)
                //                if let jsonString = String(data: jsonData, encoding: .utf8) {
                //                    print(jsonString)
                //                }
            } catch {
                print(error)
                completion(nil)
            }
        })
        dataTask.resume()
    }
    
    //MARK: Calling nearest health facilities of a certain place from Foursquare API
    func fetchNearestHealthFacilities(ll: String) /*async*/  {
        for var placeResult in placeResults {
            var resultsJSON = [HealthFacilities]()
            let concatenatedLatitudeLongitude = "\(placeResult.latitude),\(placeResult.longitude)"
            let headers = [
                "Accept": "application/json",
                "Authorization": authKey
            ]
            
            let baseURL = URL(string: "https://api.foursquare.com/v3/places/search")!
            
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "ll", value: concatenatedLatitudeLongitude),
                URLQueryItem(name: "radius", value: "3000"),
                URLQueryItem(name: "categories", value: "17145, 15014, 15016"),
                URLQueryItem(name: "limit", value: "3")
            ]
            let url = baseURL.appending(queryItems: queryItems)
            
            let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers
            
            let session = /*await*/ URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                if let error = error {
                    print(error)
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Empty Response")
                    return
                }
                
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                
                do {
                    let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                    var fetchedHealthFacilities = Set<String>() // Keep track of fetched places
                    let group = DispatchGroup()
                    
                    for result in jsonData.results {
                        let fsq_id = result.fsq_id
                        let categoriesName = result.categories.first?.name ?? ""
                        let name = result.name
                        let latitude = result.geocodes.main.latitude
                        let longitude = result.geocodes.main.longitude
                        let formatted_address = result.location.formatted_address
                        
                        var healthFacility = HealthFacilities(fsq_id: fsq_id, categories_name: categoriesName, name: name, latitude: latitude, longitude: longitude, formatted_address: formatted_address)
                        
                        if !fetchedHealthFacilities.contains(fsq_id) {
                            fetchedHealthFacilities.insert(fsq_id)
                            group.enter()
                            self.fetchImagesPlaces(fsq_id: fsq_id) { imagesData in
                                healthFacility.imagesData = imagesData
                                resultsJSON.append(healthFacility)
                                group.leave()
                            }
                        } else {
                            resultsJSON.append(healthFacility)
                        }
                    }
                    
                    group.notify(queue: .main) { [self] in
                        do {
                            placeResult.healthFacilities = resultsJSON
                            // self.placeResults = []
                            self.placeResults2.append(placeResult)
                            print("jum:\(self.placeResults2.count)")
                            let encoder = JSONEncoder()
                            encoder.outputFormatting = .prettyPrinted
                            
                            let jsonDataNew = try encoder.encode(self.placeResults2)
                            var fsqIds = [String]()
                            var placeImgPrefix = [String]()
                            var placeImgSuffix = [String]()
                            if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
                                if let healthFacilities = placeResult.healthFacilities {
                                    for _ in healthFacilities {
                                        fsqIds = healthFacilities.map { $0.fsq_id }
                                    }
                                }
                                if let placeImages = placeResult.imagesData {
                                    for _ in placeImages {
                                        placeImgPrefix = placeImages.map {$0.prefix}
                                        placeImgSuffix = placeImages.map {$0.suffix}
                                    }
                                }
                                
                                // Insert to CloudKit, don't forget to adjust the parameter category value
                                addRecordToCloudKit( name: placeResult.name, address: placeResult.formatted_address!, category: "Pusat Belanja", health_facilities_id: fsqIds, latitude: placeResult.latitude, longitude: placeResult.longitude, img_prefix: placeImgPrefix, img_suffix: placeImgSuffix, fsq_id: placeResult.fsq_id)
                                //                                print(jsonString)
                            }
                            var placeHFImgPrefix = [String]()
                            var placeHFImgSuffix = [String]()
                            if let jsonString1 = String(data: jsonDataNew, encoding: .utf8) {
                                if let healthFacilities = placeResult.healthFacilities {
                                    for healthFacility in healthFacilities {
                                        let hf_name: String = healthFacility.name
                                        let hf_fsq_id: String = healthFacility.fsq_id
                                        let hf_address: String = healthFacility.formatted_address ?? ""
                                        let hf_latitude: Double = healthFacility.latitude
                                        let hf_longitude: Double = healthFacility.longitude
                                        let hf_category: String = healthFacility.categories_name
                                        
                                        if let placeHFImages = healthFacility.imagesData {
                                            for _ in placeHFImages {
                                                placeHFImgPrefix = placeHFImages.map {$0.prefix}
                                                placeHFImgSuffix = placeHFImages.map {$0.suffix}
                                            }
                                        }
                                        
                                        addRecordHealthFacilitiesToCloudKit(name: hf_name, address: hf_address, category: hf_category, latitude: hf_latitude, longitude: hf_longitude, img_prefix: placeHFImgPrefix, img_suffix: placeHFImgSuffix, fsq_id: hf_fsq_id)
                                    }
                                }
                            }
                        } catch {
                            print("Error encoding JSON: \(error)")
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            })
            
            dataTask.resume()
        }
    }
}
