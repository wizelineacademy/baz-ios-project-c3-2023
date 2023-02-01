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
    init(id: Int, original_title: String, title: String, overview: String, backdrop_path: String, poster_path: String) {
        self.id = id
        self.original_title = original_title
        self.title = title
        self.overview = overview
        self.backdrop_path = myUrls.imagePath.rawValue + backdrop_path
        self.poster_path = myUrls.imagePath.rawValue + poster_path
    }
}
