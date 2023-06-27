//
//  FoursquareAPI.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 21/06/23.
//

import Foundation
import SwiftUI

class FoursquareAPI: ObservableObject {
    
    let authKey = "fsq3VGSxuPFXJFATJcJyeCh8BgVdQJ+b2hPrXIYtvPN4tH0="
    func fetchPlacesandImages() {
//        print("RUN fetchPlacesandImages")
        let headers = [
            "Accept": "application/json",
            "Authorization": authKey
        ]

        let baseURL = URL(string: "https://api.foursquare.com/v3/places/search")!

        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "near", value: "Surabaya"),
            URLQueryItem(name: "categories", value: "10000"),
            URLQueryItem(name: "limit", value: "50")
        ]
        let url = baseURL.appending(queryItems: queryItems)

        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 20.0)
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
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                var fetchedPlaces = Set<String>() // Keep track of fetched places
                var resultsJSON = [Place]() // Store the final results

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

                        let concatenatedLatitudeLongitude = "\(latitude),\(longitude)"

                        let group = DispatchGroup()

                        group.enter()
                        self.fetchImagesPlaces(fsq_id: fsq_id) { imagesData in
                            place.imagesData = imagesData
                            group.leave()
                        }

                        group.enter()
                        self.fetchNearestHealthFacilities(ll: concatenatedLatitudeLongitude) { healthFacilities in
                            place.healthFacilities = healthFacilities
                            group.leave()
                        }
//                        print("RUN fetchPlacesandImages2")
                        group.notify(queue: .main) {
//                            print("RUN fetchPlacesandImages3")
//                            group.enter()
//                            self.fetchNearestHealthFacilities(ll: concatenatedLatitudeLongitude) { healthFacilities in
//                                place.healthFacilities = healthFacilities
//                                group.leave()
//                            }
                            
                            resultsJSON.append(place)
//                            print(resultsJSON.count)
//                            print(fetchedPlaces.count)
                            print(resultsJSON)
                            if resultsJSON.count == fetchedPlaces.count {
                                // All places have been fetched
                                do {
                                    let encoder = JSONEncoder()
                                    encoder.outputFormatting = .prettyPrinted

                                    let jsonDataNew = try encoder.encode(resultsJSON)
                                    if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
//                                        print(jsonString)
                            
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
        })

        dataTask.resume()
    }


    // MARK: Calling Places and Images API
    
//        func fetchPlacesandImages()
//        {
//            let headers = [
//                "Accept": "application/json",
//                "Authorization": authKey
//            ]
//
//            let baseURL = URL(string: "https://api.foursquare.com/v3/places/search")!
//
//            let queryItems: [URLQueryItem] = [
//                URLQueryItem(name: "near", value: "Surabaya"),
//                URLQueryItem(name: "categories", value: "10000"),
//                URLQueryItem(name: "limit", value: "50")
//            ]
//            let url = baseURL.appending(queryItems: queryItems)
//
//            let request = NSMutableURLRequest(url: url,
//                                              cachePolicy: .useProtocolCachePolicy,
//                                              timeoutInterval: 20.0)
//            request.httpMethod = "GET"
//            request.allHTTPHeaderFields = headers
//
//            let session = URLSession.shared
//            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
//
//                if let error = error {
//                    print(error)
//                }
//
//                guard let response = response as? HTTPURLResponse else {
//                    print("Empty Response")
//                    return
//                }
//
//                guard let data = data else {
//                    print("Empty Data")
//                    return
//                }
//
//                do {
//                    let jsonData = try JSONDecoder().decode(Initial.self, from: data)
//                    var resultsJSON = [Place]()
//                    var fetchedPlaces = Set<String>() // Keep track of fetched places
//                    let group = DispatchGroup()
//
//                    for result in jsonData.results {
//                        let fsq_id = result.fsq_id
//                        let categoriesName = result.categories.first?.name ?? ""
//                        let name = result.name
//                        let latitude = result.geocodes.main.latitude
//                        let longitude = result.geocodes.main.longitude
//                        let formatted_address = result.location.formatted_address
//
//                        var place = Place(fsq_id: fsq_id, categories_name: categoriesName, name: name, latitude: latitude, longitude: longitude, formatted_address: formatted_address, healthFacilities: nil)
//
//                        if !fetchedPlaces.contains(fsq_id) {
//                            fetchedPlaces.insert(fsq_id)
//                            group.enter()
//
//                            self.fetchImagesPlaces(fsq_id: fsq_id) { imagesData in
//                                place.imagesData = imagesData
//                                resultsJSON.append(place)
//                                group.leave() // Add the place to fetched places
//                            }
//
//                            let concatenatedLatitudeLongitude = "\(latitude),\(longitude)"
//
//                            self.fetchNearestHealthFacilities(ll: concatenatedLatitudeLongitude) { healthFacilities in
//                                let healthFacilitiesDict = HealthFacilities(
//                                    fsq_id: healthFacilities.fsq_id,
//                                    categories_name: healthFacilities.categories_name,
//                                    name: healthFacilities.name,
//                                    latitude: healthFacilities.latitude,
//                                    longitude: healthFacilities.longitude,
//                                    formatted_address: healthFacilities.formatted_address,
//                                    imagesData: healthFacilities.imagesData
//                                )
//                                place.healthFacilities = healthFacilitiesDict
//                                resultsJSON.append(place)
//                                group.leave()
//                            }
//
//                        } else {
//                            resultsJSON.append(place)
//                        }
//
//                    }
//
//                    group.notify(queue: .main) {
//                        do {
//                            let encoder = JSONEncoder()
//                            encoder.outputFormatting = .prettyPrinted
//
//                            let jsonDataNew = try encoder.encode(resultsJSON)
//                            if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
//                                print(jsonString)
//                            }
//                        } catch {
//                            print("Error encoding JSON: \(error)")
//                        }
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            })
//
//            dataTask.resume()
//
//        }
    
    
    //MARK: Calling Places Images API
    func fetchImagesPlaces(fsq_id: String, completion: @escaping ([images]?) -> Void) -> Void
    {
        
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
            
            do{
                let imagesData = try JSONDecoder().decode([images].self, from: data)
                completion(imagesData)
                
                
                // Print the JSON result
                //                let encoder = JSONEncoder()
                //                encoder.outputFormatting = .prettyPrinted
                //
                //                let jsonData = try encoder.encode(imagesData)
                //                if let jsonString = String(data: jsonData, encoding: .utf8) {
                //                    print(jsonString)
                //                }
            }
            catch
            {
                print(error)
                completion(nil)
            }
        })
        
        dataTask.resume()
        
    }
    
    //MARK: Calling Nearest Health Facilities API
    func fetchNearestHealthFacilities(ll: String, completion: @escaping (HealthFacilities) -> Void)
    {
//        print("RUN fetchNearestHealthFacilities")
        let headers = [
            "Accept": "application/json",
            "Authorization": authKey
        ]
        
        let baseURL = URL(string: "https://api.foursquare.com/v3/places/search")!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: ll),
            URLQueryItem(name: "radius", value: "3000"),
            URLQueryItem(name: "categories", value: "17145, 15014, 15016"),
            URLQueryItem(name: "limit", value: "5")
        ]
        let url = baseURL.appending(queryItems: queryItems)
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 20.0)
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
                let jsonData = try JSONDecoder().decode(Initial.self, from: data)
                var resultsJSON = [HealthFacilities]()
                var fetchedPlaces = Set<String>() // Keep track of fetched places
                let group = DispatchGroup()
                
                for result in jsonData.results {
                    let fsq_id = result.fsq_id
                    let categoriesName = result.categories.first?.name ?? ""
                    let name = result.name
                    let latitude = result.geocodes.main.latitude
                    let longitude = result.geocodes.main.longitude
                    let formatted_address = result.location.formatted_address
                    
                    var healthFacility = HealthFacilities(fsq_id: fsq_id, categories_name: categoriesName, name: name, latitude: latitude, longitude: longitude, formatted_address: formatted_address)
                    
                    if !fetchedPlaces.contains(fsq_id) {
                        fetchedPlaces.insert(fsq_id)
                        group.enter()
                        
                        self.fetchImagesPlaces(fsq_id: fsq_id) { imagesData in
                            healthFacility.imagesData = imagesData
                            resultsJSON.append(healthFacility)
                            group.leave() // Add the place to fetched places
                        }
                        
                        
                    } else {
                        resultsJSON.append(healthFacility)
                    }
                    
                }
                
                group.notify(queue: .main) {
                    do {
                        let encoder = JSONEncoder()
                        encoder.outputFormatting = .prettyPrinted
                        
                        let jsonDataNew = try encoder.encode(resultsJSON)
                        if let jsonString = String(data: jsonDataNew, encoding: .utf8) {
//                            print(jsonString)
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
