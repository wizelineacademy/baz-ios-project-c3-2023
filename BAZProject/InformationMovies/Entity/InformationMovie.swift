//
//  InformationMovie.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import Foundation

// MARK: - InformationMovie
struct InformationMovie: Codable {
    let adult: Bool?
    let backdrop_path: String?
    let genres: [Genre]?
    let id: Int?
    let title: String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let release_date: String?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
