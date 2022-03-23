//
//  Result.swift
//  Yelp Business Index
//
//  Created by Fauzi Achmad B D on 23/03/22.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let businesses: [Business]
    let total: Int
    let region: Region
}
