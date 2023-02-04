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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
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
