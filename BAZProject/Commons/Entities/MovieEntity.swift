//
//  MovieEntity.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import UIKit

struct Movie: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let popularity: Double?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getImage(completion: @escaping(UIImage?) -> Void) {
        if let posterPath = self.posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage(completion: completion)
        }
    }
}
