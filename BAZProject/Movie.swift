//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movies: Codable {
    let page: Int
    let results: [Result]

}

// MARK: - Result
struct Result: Codable {
    let backdropPath: String?
    let id: Int
    let title: String
    let overview : String
    let posterPath: String?
    let popularity: Double
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
