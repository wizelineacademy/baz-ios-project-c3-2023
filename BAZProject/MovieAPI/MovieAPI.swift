//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let language: String = "language=es"
    var requestType: MovieAPICategory = .Top_Rated
    

    func getMovies() -> [Movie] {
        guard let urlTrendingMovies = URL(string: "https://api.themoviedb.org/3/\(requestType.rawValue)?api_key=\(apiKey)&\(language)"),
              let data = try? Data(contentsOf: urlTrendingMovies),
              let json = try? JSONDecoder().decode(MovieAPIResult.self, from: data)
        else {
            return []
        }
        return json.results
    }
    
}
