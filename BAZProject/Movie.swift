//
//  Movie.swift
//  BAZProject
//
//

import Foundation
import UIKit

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int?
    let title: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let mediaType: String?
    let genreIds: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var posterImagefullPath: String {
        return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case adult            = "adult"
        case backdropPath     = "backdrop_path"
        case id               = "id"
        case title            = "title"
        case originalLanguage = "original_language"
        case originalTitle    = "original_title"
        case overview         = "overview"
        case posterPath       = "poster_path"
        case mediaType        = "media_type"
        case genreIds         = "genre_ids"
        case popularity       = "popularity"
        case releaseDate      = "releaseDate"
        case video            = "video"
        case voteAverage      = "vote_average"
        case voteCount        = "vote_count"
        
    }
}
