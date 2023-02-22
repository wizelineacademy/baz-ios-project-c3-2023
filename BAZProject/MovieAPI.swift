//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    func getMovies() -> [Movie] {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=1"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        var movies: [Movie] = []
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
            }
        }
        
        return movies
    }
    
    func getImageMovie(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil{
                guard let dataImage = data, let image = UIImage(data: dataImage) else {return}
                completion(image)
            }
        }.resume()
    }
    

    func getAllMovies() -> [Movie]{
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        var allMovies: [Movie] = []
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                allMovies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
            }
        }
        return allMovies

    }
    
}
