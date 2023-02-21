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
    
    init(id: Int, originalTitle: String, title: String, overview: String, posterPath: String) {
        self.id = id
        self.originalTitle = originalTitle
        self.title = title
        self.overview = overview
        self.posterPath = myUrls.imagePath.rawValue + posterPath
    }
}
