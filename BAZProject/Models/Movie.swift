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
    let backdropPath: String
    var imagePrincipal: UIImage?
    var imageSecundary: UIImage?
    init(id: Int, originalTitle: String, title: String, overview: String, backdropPath: String, posterPath: String) {
        self.id = id
        self.originalTitle = originalTitle
        self.title = title
        self.overview = overview
        self.backdropPath = myUrls.imagePath.rawValue + backdropPath
        let api = MovieAPI()
        self.imagePrincipal = {
            api.getImage(from: myUrls.imagePath.rawValue + posterPath)
        }()
        self.imageSecundary = {
            api.getImage(from: myUrls.imagePath.rawValue + backdropPath)
        }()
    }
}
