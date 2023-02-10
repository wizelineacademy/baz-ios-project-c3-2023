//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
    
     var urlImage: String{
        return "https://image.tmdb.org/t/p/w500/\(poster_path)"
        
    }
}


