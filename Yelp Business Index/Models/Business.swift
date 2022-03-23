//
//  Business.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClaimed, isClosed: Bool
    let url: String
    let phone, displayPhone: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let location: Location
    let coordinates: Coordinates
    let photos: [String]
    let price: String
    let hours: [Hour]
    let transactions: [String]
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double
}

// MARK: - Region
struct Region: Codable {
    let center: Center
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Int
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String
    let zipCode, country, state: String
    let displayAddress: [String]
    let crossStreets: String
}
