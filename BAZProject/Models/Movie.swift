//
//  Movie.swift
//  BAZProject
//
//

import UIKit

struct Movie{
    
    let id: Int
    let original_title: String
    let title: String
    let overview : String
    let backdrop_path: String
    var imagePrincipal: UIImage?
    var imageSecundary: UIImage?
    init(id: Int, original_title: String, title: String, overview: String, backdrop_path: String, poster_path: String) {
        self.id = id
        self.original_title = original_title
        self.title = title
        self.overview = overview
        self.backdrop_path = myUrls.imagePath.rawValue + backdrop_path
        let api = MovieAPI()
        self.imagePrincipal = {
            api.getImage(urlString: myUrls.imagePath.rawValue + poster_path)
        }()
        self.imageSecundary = {
            api.getImage(urlString: myUrls.imagePath.rawValue + backdrop_path)
        }()
    }
}
