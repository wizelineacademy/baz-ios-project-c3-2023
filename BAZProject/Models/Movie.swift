//
//  Movie.swift
//  BAZProject
//
//  Created by 1034209 on 02/02/23.
//

import Foundation

///  MovieFetchResponse is a structure used to decode information obtained from fetchMovies services
struct MovieFetchResponse: Decodable {
    let page: Int?
    let results: [Movie]
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let title, originalLanguage, originalTitle, overview: String?
    let posterPath, mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
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
