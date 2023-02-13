//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String?
    let poster_path: String?
    let backdrop_path: String?
    let adult: Bool?
    let original_language: String?
    let overview: String?
    let popularity: Float?
    let release_date: String?
    let video: Bool?
    let vote_average: Float?
    let vote_count: Int?
}
