//
//  MovieDetail.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 04/02/23.
//

import Foundation

struct MovieDetail: Decodable {
    let overview: String?
    let releaseDate: String
    let popularity: Double
    let genres: [MovieGenres]?
    
    enum CodingKeys: String, CodingKey {
        case overview = "overview"
        case releaseDate = "release_date"
        case popularity = "popularity"
        case genres = "genres"
    }
}

extension MovieDetail{
    var listGenres: String {
        var genresInList = ""
        genres?.forEach({ genre in
            genresInList =  genresInList + " " + genre.name
        })
        return genresInList
    }
}
