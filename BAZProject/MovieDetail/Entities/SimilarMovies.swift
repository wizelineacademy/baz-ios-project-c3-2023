//
//  SimilarMovies.swift
//  BAZProject
//
//  Created by hlechuga on 17/02/23.
//

import Foundation


struct SimilarMovie: Codable{
   let id: Int
   let originalLanguage: String
   let originalTitle: String
   let overview: String
   let releaseDate: String
   let posterPath: String
   let popularity: Double
   let title: String
   let video: Bool
   let voteAverage: Int
   let voteCount: Int
    
    enum CodingKeys: String, CodingKey{
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case popularity
        case title
        case video
        case voteAverage = "vote_averge"
        case voteCount = "vote_count"
    }
}

struct SimilarMovies: Codable {
    let page: Int
    let results: [SimilarMovie]
    let totalPages: Int
    let totalResults : Int
    
    enum CodingKeys: String, CodingKey{
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
