//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let voteAverage: Double
    let backdropPath: String?
    let overview: String?
    let releaseDate: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case popularity = "popularity"
    }
}

extension Movie{
    var averageStars: String {
        guard self.voteAverage > 0 else { return " " }
        let stars = (self.voteAverage/2.0).rounded()
        var strStars: String = ""
        for _ in 1...Int(stars) {
            strStars = strStars + "⭐️"
        }
        return strStars
    }
}
