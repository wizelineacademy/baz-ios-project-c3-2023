//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI: GenericAPI {
    var baseURL = "https://api.themoviedb.org"
    var apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    /**
       This function retrieves the data as  `MovieResult`   from  `url`
       "https://api.themoviedb.org"
     
        - Parameters:
          - endpoint: it´s an Enum `MovieServices` 
          - onComplation: its a block code that recibe Result and returns void `(Result<MovieResult, Error>) -> Void`
     */
    func getMovies(endpoint: MovieServices, onCompletion: @escaping (Result<MovieResult, Error>) -> Void) {
        fetch(urlRequest: endpoint.request, onCompletion: onCompletion)
    }
    
    /**
       This function retrieves the data as  `ReviewResult`   from  `url`
       "https://api.themoviedb.org"
     
        - Parameters:
          - endpoint: it´s an Enum `MovieServices`
          - onComplation: its a block code that recibe Result and returns void `(Result<Reviews, Error>) -> Void`
     */
    func getReviews(endpoint: MovieServices, onCompletion: @escaping (Result<Reviews, Error>) -> Void) {
        fetch(urlRequest: endpoint.request, onCompletion: onCompletion)
    }
    
    /**
       This function retrieves the data as  `CastResult`   from  `url`
       "https://api.themoviedb.org"
     
        - Parameters:
          - endpoint: it´s an Enum `MovieServices`
          - onComplation: its a block code that recibe Result and returns void `(Result<CastResult, Error>) -> Void`
     */
    func getCast(endpoint: MovieServices, onCompletion: @escaping (Result<CastResult, Error>) -> Void) {
        fetch(urlRequest: endpoint.request, onCompletion: onCompletion)
    }
    
}
