//
//  SearchingEntities.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

struct SearchResult: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    func getImage(completion: @escaping(UIImage?) -> Void) {
        if let posterPath = self.backdropPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage() { image in
                completion(image)
            }
        }
    }
}
