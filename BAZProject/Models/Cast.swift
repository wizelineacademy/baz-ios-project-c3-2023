//
//  Cast.swift
//  BAZProject
//
//  Created by 1034209 on 28/02/23.
//

import Foundation

// MARK: - CastResponse
struct CastResponse: Decodable {
    let id: Int?
    let cast: [Cast]?
}

// MARK: - Cast
struct Cast: Decodable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character, creditID: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order
    }
}

struct CastSearch: CarruselCollectionItemProperties {
    var id: Int
    var imageURL: String
    var name: String
    var description: String
}
