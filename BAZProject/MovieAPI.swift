//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let urlBase = "https://api.themoviedb.org/3"
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies() -> [Movie] {
        guard let url = URL(string: urlBase+"/trending/movie/day?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }

        return parseData(results: results)
    }

    private func parseData(results: [NSDictionary]) -> [Movie] {
        var movies: [Movie] = []
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path))
            }
        }

        return movies
    }
}
