//
//  MoviesAPI.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieServicesProtocol {
    func fetchMovies(type: fetchMoviesTypes, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void)
    func fetchReviews(id: Int, completionHandler: @escaping([Review], MovieServiceError?) -> Void)
}

class MoviesAPI: MovieServicesProtocol {
    
    let urlBaseString = "https://api.themoviedb.org/3"
    let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let language = "es"
    let region = "MX"
    let page = 1

    let sessionShared = URLSession.shared
    
    func fetchMovies(type: fetchMoviesTypes, completionHandler: @escaping ([Movie], MovieServiceError?) -> Void) {
        
        let request = URLRequest(url: getURL(endpoint: type.endpoint))
        
        sessionShared.dataTask(with: request) { data, error, response in
            guard let data = data else {
                completionHandler([], .fetchError(error as! Error))
                return
            }
            do {
                let movies = try JSONDecoder().decode(MovieFetchResponse.self, from: data).results
                completionHandler(movies, nil)
            } catch {
                completionHandler([], .decodeError(error))
            }
        }.resume()
    }
    
    func fetchReviews(id: Int, completionHandler: @escaping ([Review], MovieServiceError?) -> Void) {
        
        let request = URLRequest(url: getURL(endpoint: .movieReviews(id: id)))

        sessionShared.dataTask(with: request) { data, error, response in
            guard let data = data else {
                completionHandler([], .fetchError(error as! Error))
                return
            }
            do {
                let reviews = try JSONDecoder().decode(ReviewResponse.self, from: data).results
                completionHandler(reviews, nil)
            } catch {
                completionHandler([], .decodeError(error))
            }
        }.resume()
    }
    
    func getURL(endpoint: Endpoint) -> URL {
        URL(string: "\(urlBaseString)\(endpoint.url)?api_key=\(apiKey)\(endpoint.queryString)&language=\(language)&region=\(region)&page=\(page)")!
    }
}

/// fetchMoviesTypes defines the type to fetch movies based on their type
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
    case decodeError(Error)
}
