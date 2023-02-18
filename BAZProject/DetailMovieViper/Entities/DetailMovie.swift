//
//  DetailMovie.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//

import Foundation

struct DetailMovie: Codable{
    let id: Int
    let original_title: String?
    let backdrop_path: String?
    let release_date: String?
    let overview: String?
    let runtime: Int?
    let genres: [GenresMovie]?
}

struct GenresMovie: Codable{
    let id: Int
    let name: String?
}

struct Reviews: Codable{
    let author: String?
    let content: String?
    let created_at: String?
}

struct Cast: Codable{
    let name: String?
    let profile_path: String?
    let character: String?
}
