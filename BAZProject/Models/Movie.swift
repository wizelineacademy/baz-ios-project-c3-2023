//
//  Movie.swift
//  BAZProject
//
//  Created by 1034209 on 02/02/23.
//

import Foundation
import UIKit

protocol MovieProperties {
    var adult: Bool? { get set }
    var backdropPath: String? { get set }
    var id: Int? { get set }
    var title: String? { get set }
    var originalLanguage: String? { get set }
    var originalTitle: String? { get set }
    var overview: String? { get set }
    var posterPath: String? { get set }
    var mediaType: String? { get set }
    var genreIDS: [Int]? { get set }
    var popularity: Double? { get set }
    var releaseDate: String? { get set }
    var video: Bool? { get set }
    var voteAverage: Double? { get set }
    var voteCount: Int? { get set }
}

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

struct Movie: MovieProperties, Decodable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var title: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var mediaType: String?
    var genreIDS: [Int]?
    var popularity: Double?
    var releaseDate: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
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

struct MoviesBySection {
    var titleSection: String
    var movies: [Movie]
}

struct MovieSearch {
    var id: Int
    var imageURL: String
    var title: String
}


