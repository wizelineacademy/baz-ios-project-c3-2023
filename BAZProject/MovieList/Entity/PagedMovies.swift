//
//  PagedMovies.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

struct PagedMovies: Decodable {
    let movies: [Movie]
    let totalPages: Int
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
        case page
    }
}
