//
//  Actors.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 01/03/23.
//

import Foundation

struct CastResult: Decodable {
    var id: Int?
    var cast: [Cast]?
    var crew: [Cast]?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
        case crew = "crew"
    }
}


struct Cast: Decodable {
    var adult: Bool?
    var gender: Int?
    var id: Int?
    var knownForDepartment: String?
    var name: String?
    var originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castID: Int?
    var character: String?
    var creditID: String?
    var order: Int?
    var department: String?
    var job: String?

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case gender = "gender"
        case id = "id"
        case knownForDepartment = "known_for_department"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character = "character"
        case creditID = "credit_id"
        case order = "order"
        case department = "department"
        case job = "job"
    }
}

