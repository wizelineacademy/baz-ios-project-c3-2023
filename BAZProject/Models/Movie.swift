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
    let poster_path: String
    let image: UIImage?
    init(id: Int, original_title: String, title: String, overview: String, backdrop_path: String, poster_path: String) {
        self.id = id
        self.original_title = original_title
        self.title = title
        self.overview = overview
        self.backdrop_path = backdrop_path
        self.poster_path = poster_path
        let urlBase = "https://image.tmdb.org/t/p/w500/"
        
        if let urlImage = URL(string: urlBase + poster_path) {
            self.image = UIImage(data: try! Data(contentsOf: urlImage)) ?? UIImage()
        } else {
            self.image = UIImage()
        }
    }
}

