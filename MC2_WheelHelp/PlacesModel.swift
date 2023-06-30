//
//  Model.swift
//  MC2_WheelHelp
//
//  Created by Dyah Putri Nariswari on 21/06/23.
//

import Foundation

struct Place: Codable {
    let fsq_id: String
    let categories_name: String
    let name: String
    let latitude: Double
    let longitude: Double
    let formatted_address: String?
    var imagesData: [images]?
    var healthFacilities: [HealthFacilities]?

    private enum CodingKeys: String, CodingKey {
        case fsq_id
        case categories_name
        case name
        case latitude
        case longitude
        case formatted_address
        case imagesData
        case healthFacilities
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fsq_id, forKey: .fsq_id)
        try container.encode(categories_name, forKey: .categories_name)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(formatted_address, forKey: .formatted_address)
        try container.encodeIfPresent(imagesData, forKey: .imagesData)
        try container.encodeIfPresent(healthFacilities, forKey: .healthFacilities)
    }
}


struct HealthFacilities: Codable {
    let fsq_id: String
    let categories_name: String
    let name: String
    let latitude: Double
    let longitude: Double
    let formatted_address: String?
    var imagesData: [images]?

    private enum CodingKeys: String, CodingKey {
        case fsq_id
        case categories_name
        case name
        case latitude
        case longitude
        case formatted_address
        case imagesData
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fsq_id, forKey: .fsq_id)
        try container.encode(categories_name, forKey: .categories_name)
        try container.encode(name, forKey: .name)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(formatted_address, forKey: .formatted_address)
        try container.encodeIfPresent(imagesData, forKey: .imagesData)
    }
}


struct Response: Codable {
    let hasil: [hasil]
}

struct hasil: Codable {
    let fsq_id:String
    let name:String
}

struct Initial:Hashable,Codable
{
    let results: [results]
}

struct results:Hashable,Codable
{
    let fsq_id:String
    let categories: [categories]
    let chains: [chains]
    let distance: Float
    let name:String
    let geocodes: geocodes
    let location: location
   
}

struct categories:Hashable,Codable
{
    let id: Int
    let name:String
}

struct geocodes:Hashable,Codable
{
    let main: main
}

struct location:Hashable, Codable
{
    let formatted_address: String
}

struct main: Hashable,Codable
{
    let latitude: Double
    let longitude: Double
}
struct chains:Hashable,Codable
{
    
}
struct images:Hashable,Codable
{
    let prefix: String
    let suffix: String
}
