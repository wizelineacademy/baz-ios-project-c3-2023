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
    let backdropPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}

extension Movie{
    
    var avarageRounded: String {
        if self.voteAverage >= 1 {
            return String(format: "%.2f", self.voteAverage)
        } else {
            return ""
        }
    }
    
    var averageStars: String {
        guard self.voteAverage > 0 else { return " " }
        let stars = (self.voteAverage/2.0).rounded()
        var strStars: String = ""
        for _ in 1...Int(stars) {
            strStars = strStars + "⭐️"
        }
        return strStars
    }
    
    static func searchMovieByID(movieID: Int, listOfCategories: [MovieAPICategory: [Movie]]) -> Movie? {
        var movieFind: Movie?
        for category in listOfCategories {
            category.value.forEach { movie in
                if movie.id ==  movieID{
                    movieFind = movie
                }
            }
        }
        return movieFind
    }
    
}
