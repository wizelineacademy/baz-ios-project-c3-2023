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
    let overview: String
//    var cast: [Cast] = []
//    var reviews: [Reviews] = []

     var urlImage: String{
        return "https://image.tmdb.org/t/p/w500/\(poster_path)"
    }
}
struct Cast: Codable {
    let name: String?
    let profile_path: String?
    let character: String?
}

struct Reviews: Codable{
    let author: String?
    let content: String?
    let created_at: String?
}

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let total_results: Int
    let total_pages: Int
}


