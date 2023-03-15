//
//  Movie.swift
//  BAZProject
//
//

import Foundation

///This structs represents a movie object with its properties.

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
    let overview: String
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


