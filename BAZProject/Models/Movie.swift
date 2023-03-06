//
//  Movie.swift
//  BAZProject
//
//

import UIKit

struct Movie {
    
    let id: Int
    let originalTitle: String
    let title: String
    let overview : String
    let posterPath: String
    var imagePrincipal: UIImage?
    var imageSecundary: UIImage?
    let genresArray: [genres]
    let vote_average: Int?
 
    init(id: Int, originalTitle: String, title: String, overview: String, posterPath: String, genre_ids: [Int], vote_average: Int?) {
        self.id = id
        self.originalTitle = originalTitle
        self.title = title
        self.overview = overview
        self.posterPath = myUrls.imagePath.rawValue + posterPath
        self.genresArray = genre_ids.map({ genres(rawValue: $0) ?? genres.Desconocido })
        self.vote_average = vote_average
    }
}
