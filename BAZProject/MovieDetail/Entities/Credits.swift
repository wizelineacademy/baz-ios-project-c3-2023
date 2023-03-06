//
//  Credits.swift
//  BAZProject
//
//  Created by hlechuga on 16/02/23.
//

import Foundation

struct Credits: Codable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Codable {
    let id: Int
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String?
    let creditId: String?
    let order: Int
    var fullProfilePath : String {
        return "https://image.tmdb.org/t/p/w200\(profilePath ?? "")"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order 
    }
}
