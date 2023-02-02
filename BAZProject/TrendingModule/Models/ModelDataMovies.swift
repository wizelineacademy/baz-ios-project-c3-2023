//
//  ModelDataMovies.swift
//  BAZProject
//
//  Created by avirgilio on 31/01/23.
//

import Foundation

//   let movieModel = try? JSONDecoder().decode(MovieModel.self, from: jsonData)

// MARK: - MovieModel
struct MovieModel: Codable {
    let page: Int
    let results: [ResultMovie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultMovie: Codable {
    let backdropPath: String
    let title, originalTitle, overview: String
    let posterPath: String
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
