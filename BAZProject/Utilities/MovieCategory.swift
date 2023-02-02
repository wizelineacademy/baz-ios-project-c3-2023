//
//  Filters.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 26/01/23.
//

import Foundation

enum MovieCategory {
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
    
    /**
     Regresa la URL del end point correspondiente a cada categoria
     - Parameters:
        - page: un entero que representa la página del listado de peliculas
     - Returns: la URL correspondiente al end point construida a partir de la URL base, tiene como atributos la pagina, el api key y el idioma, siendo estos ultimos valores constantes
     */
    func getEndPoint(for page: Int) -> URL? {
        switch self {
        case .trending:
            return getBaseURL(for: page)?.appendingPathComponent("/trending/movie/day")
        case .nowPlaying:
            return getBaseURL(for: page)?.appendingPathComponent("/movie/now_playing")
        case .popular:
            return getBaseURL(for: page)?.appendingPathComponent("/movie/popular")
        case .topRated:
            return getBaseURL(for: page)?.appendingPathComponent("/movie/top_rated")
        case .upcoming:
            return getBaseURL(for: page)?.appendingPathComponent("/movie/upcoming")
        }
    }
    
    private func getBaseURL(for page: Int) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: "es")
        ]
        return urlComponents.url
    }
}
