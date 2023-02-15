//
//  MovieCast.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 07/02/23.
//

import Foundation

struct MovieCast: Decodable {
    let id: Int
    let gender: Int?
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let character: String
    let order: Int
    let knownForDepartment: String
    
    enum CodingKeys: String, CodingKey{
        case id =  "id"
        case gender = "gender"
        case name = "name"
        case originalName = "original_name"
        case popularity = "popularity"
        case profilePath = "profile_path"
        case character = "character"
        case order = "order"
        case knownForDepartment = "known_for_department"
    }
}

extension MovieCast {
    var nameAndCharacter: String {
        "\(self.name) \n \(self.character)"
    }
}
