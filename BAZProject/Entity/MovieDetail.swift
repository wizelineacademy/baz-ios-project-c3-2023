//
//  MovieDetail.swift
//  BAZProject
//
//  Created by nsanchezj on 03/02/23.
//

import Foundation

struct MovieDetail: Codable {
    let adult: Bool
    let originalLanguage: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case originalLanguage = "original_language"
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
