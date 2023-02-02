//
//  MoviesAPI.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieServicesProtocol {
    func fetchMovies(type: fetchMoviesTypes, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void)
    func fetchReview(id: Int, completionHandler: @escaping([Review], MovieServiceError?) -> Void)
}

class MoviesAPI: MovieServicesProtocol {
    
    let urlBaseString = "https://api.themoviedb.org/3"
    let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let language = "es"
    let region = "MX"
    let page = 1

    let sessionShared = URLSession.shared
    
    func fetchMovies(type: fetchMoviesTypes, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void) {
    
    }
    
    func fetchReview(id: Int, completionHandler: @escaping ([Review], MovieServiceError?) -> Void) {
        
    }
    
    func getURL(endpoint: Endpoint) -> URL {
        URL(string: "\(urlBaseString)\(endpoint.url)?api_key=\(apiKey)&language=\(language)&region=\(region)&page=\(page)")!
    }
}

enum fetchMoviesTypes {
    case trending, nowPlaying, popular, topRated, upComing, byKeyword(String), bySearch(String), bySimilarMovie(id: Int), byRecommendationMovie(id: Int)
    
    var endpoint: Endpoint {
        switch self {
        case .trending:
            return Endpoint.trending
        case .nowPlaying:
            return Endpoint.nowPlaying
        case .popular:
            return Endpoint.popular
        case .topRated:
            return Endpoint.topRated
        case .upComing:
            return Endpoint.upComing
        case .byKeyword(let string):
            return Endpoint.byKeyword(string)
        case .bySearch(let string):
            return Endpoint.bySearch(string)
        case .bySimilarMovie(let id):
            return Endpoint.bySimilarMovie(id: id)
        case .byRecommendationMovie(let id):
            return Endpoint.byRecommendationMovie(id: id)
        }
    }
}

enum MovieServiceError: Error {
    case fetchError(Error)
}
