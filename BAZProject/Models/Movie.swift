//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let vote_average: Double
    var averageStars: String {
        guard vote_average > 0 else {return " "}
        let stars = (vote_average/2.0).rounded()
        var strStars: String = ""
        for _ in 1...Int(stars){
            strStars = strStars + "⭐️"
        }
        return strStars
    }
}
