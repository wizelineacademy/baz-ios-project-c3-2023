//
//  CVMovieApiResponse.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 17/04/23.
//

import Foundation

struct CVMovieItem: Codable {
    let id: Int?
    let title: String?
    let poster_path: String?
    let vote_average: Double?
    let overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case poster_path
        case vote_average
        case overview
    }
}


struct CVMovieApiResponse: Codable {
    let results: [CVMovieItem]
}
