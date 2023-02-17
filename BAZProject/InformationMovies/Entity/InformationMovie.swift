//
//  InformationMovie.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

// MARK: - InformationMovie
struct InformationMovie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genres: [Genre]?
    let id: Int?
    let title: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres
        case id
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
