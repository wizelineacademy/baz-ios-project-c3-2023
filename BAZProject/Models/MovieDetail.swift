//
//  MovieDetail.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 04/02/23.
//

import Foundation

struct MovieDetail: Decodable {
    let backdropPath: String?
    let overview: String?
    let releaseDate: String
    let popularity: Double
    let genres: MovieGenres?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case popularity = "popularity"
        case genres
    }
}
