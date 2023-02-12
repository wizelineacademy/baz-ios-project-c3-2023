//
//  Filters.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 26/01/23.
//

import Foundation

enum MovieCategory: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    /** Regresa el nombre de la categoria correspondiente */
    var name: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
    
    var itemName: String {
        switch self {
        case .trending:
            return "magazine"
        case .nowPlaying:
            return "newspaper"
        case .popular:
            return "studentdesk"
        case .topRated:
            return "backpack"
        case .upcoming:
            return "lanyardcard"
        }
    }
    
    /**
     Regresa la URL del end point correspondiente a cada categoria
     - Parameters:
        - page: un entero que representa la página del listado de peliculas
     - Returns: la URL correspondiente al end point construida a partir de la URL base
     */
    func getEndPoint(for page: Int) -> URL? {
        switch self {
        case .trending:
            return MovieAPI.getBaseURL(for: page)?.appendingPathComponent("/trending/movie/day")
        case .nowPlaying:
            return MovieAPI.getBaseURL(for: page)?.appendingPathComponent("/movie/now_playing")
        case .popular:
            return MovieAPI.getBaseURL(for: page)?.appendingPathComponent("/movie/popular")
        case .topRated:
            return MovieAPI.getBaseURL(for: page)?.appendingPathComponent("/movie/top_rated")
        case .upcoming:
            return MovieAPI.getBaseURL(for: page)?.appendingPathComponent("/movie/upcoming")
        }
    }
}
