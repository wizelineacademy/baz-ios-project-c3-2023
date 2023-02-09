//
//  Trending.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 08/02/23.
//

import UIKit

struct Trending: Codable {
    let page: Int
    let results: [ResultTrending]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultTrending: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title: String
    let originalLanguage: OriginalLanguageTrending
    let originalTitle, overview, posterPath: String
    let mediaType: MediaTypeTrending
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MediaTypeTrending: String, Codable {
    case movie = "movie"
}

enum OriginalLanguageTrending: String, Codable {
    case en = "en"
    case es = "es"
    case nl = "nl"
    case ta = "ta"
}
