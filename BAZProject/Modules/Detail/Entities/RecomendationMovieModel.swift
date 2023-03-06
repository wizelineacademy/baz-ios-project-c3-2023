//  RecomendationMovieModel.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 02/03/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - RecomendationMovieModelResponse
struct RecomendationMovieModelResponse: Codable {
    var page: Int?
    var results: [RecomendationMovieModelResult]?
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - RecomendationMovieModelResult
struct RecomendationMovieModelResult: Codable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var title: String?
    var originalTitle, overview, posterPath: String?
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
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
