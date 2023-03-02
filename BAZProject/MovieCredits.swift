//
//  MovieCredits.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 09/02/23.
//

import Foundation

struct Credit: Codable {
    let id: Int
    let cast, crew: [Cast]
}

struct Cast: Codable {
    let name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
    }
}
