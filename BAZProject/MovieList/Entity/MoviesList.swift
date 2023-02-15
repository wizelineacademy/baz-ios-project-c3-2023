//
//  MoviesList.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import Foundation

struct MoviesList: Codable {
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
