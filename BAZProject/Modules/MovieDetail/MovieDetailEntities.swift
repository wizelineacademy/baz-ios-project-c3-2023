//
//  MovieDetailEntities.swift
//  BAZProject
//
//  Created by 1029187 on 21/02/23.
//

import Foundation

struct MovieDetail: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case status
    }
}
