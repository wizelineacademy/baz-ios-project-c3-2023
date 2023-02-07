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
        guard let url = URL(string: "\(baseURL)\(endpoint.path)?api_key=\(apiKey)") else {
          return onCompletion(.failure(APIError.urlError))
        }
        fetch(urlRequest: URLRequest(url: url), onCompletion: onCompletion)
    }
}
