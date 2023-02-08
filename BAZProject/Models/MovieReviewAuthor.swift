//
//  MovieReviewAuthor.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 07/02/23.
//

import Foundation

struct MovieReviewAuthor: Decodable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int?
    
    enum CodignKeys: String, CodingKey{
        case name = "name"
        case username = "username"
        case avatarPath = "avatar_path"
        case rating = "rating"
    }
}

extension MovieReviewAuthor{
    var averageStars: String {
        guard let rating = rating,
            rating > 0 else { return " " }
        let stars = (Double(rating)/2.0).rounded()
        var strStars: String = ""
        for count in 0..<5 {
            if count < Int(stars){
                strStars = strStars + "★"
            } else {
                strStars = strStars + "☆"
            }
        }
        return strStars
    }
}
