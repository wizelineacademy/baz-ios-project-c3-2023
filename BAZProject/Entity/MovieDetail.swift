//
//  MovieDetail.swift
//  BAZProject
//
//  Created by nsanchezj on 03/02/23.
//

import Foundation

/**
 MovieDetail
 Get details for each movie and implements protocol decodable for get data to struct
 */

struct MovieDetail: Decodable {
    let adult: Bool
    let originalLanguage: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case adult, status
        case originalLanguage = "original_language"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.status = try container.decode(String.self, forKey: .status)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
    }
}
