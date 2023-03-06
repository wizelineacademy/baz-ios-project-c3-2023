//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {
    /// The API key used to access the Movie API
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    /// The base URL of the Movie API
    let urlBase: String = "https://api.themoviedb.org"
    
    //MARK: - Funtions that return the info movies
    
    /// Returns an array of `Movie` objects by making a request to the Movie API to retrieve the movies that were released on the current day.
    ///
    /// - Returns: An array of `Movie` objects, or an empty array if an error occurs.
    ///
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }
            
            var movies: [Movie] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    
                    let movie = Movie(id: id, title: title, poster_path: poster_path, overview: overview)
                    
                    movies.append(movie)
                }
            }
            
            completion(movies)
        }
        
        task.resume()
    }
    
    /// Returns an array of `Movie` objects by making a request to the Movie API to retrieve the movies that were released on the current day.
    ///
    /// - Returns: An array of `Movie` objects, or an empty array if an error occurs.
    func getNowPlayingMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/now_playing?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }
            
            var movies: [Movie] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    
                    let movie = Movie(id: id, title: title, poster_path: poster_path, overview: overview)
                    
                    movies.append(movie)
                }
            }
            
            completion(movies)
        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/popular?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }
            
            var movies: [Movie] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    
                    let movie = Movie(id: id, title: title, poster_path: poster_path, overview: overview)
                    
                    movies.append(movie)
                }
            }
            
            completion(movies)
        }
        
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/upcoming?api_key=\(apiKey)&language=es") else {
            completion([])
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }
            
            var movies: [Movie] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    
                    let movie = Movie(id: id, title: title, poster_path: poster_path, overview: overview)
                    
                    movies.append(movie)
                }
            }
            completion(movies)
        }
        
        task.resume()
    }
    
    func getRatedMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error: \(error!)")
                completion([])
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }
            
            var ratedMovies: [Movie] = []
            
            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    ratedMovies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
                }
            }
            
            completion(ratedMovies)
        }
        
        task.resume()
    }

// MARK: -  Get image Movies
    /// Get an image for a given movie using its URL.
    /// - Parameters:
    ///   - urlString: The URL of the image to retrieve.
    ///   - completion: A closure to call with the retrieved image.
    func getImageMovie(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil{
                guard let dataImage = data, let image = UIImage(data: dataImage) else {return}
                completion(image)
            }
        }.resume()
    }
    
   // MARK: - Function to get movies to searchbar
    
    /// Searches for movies in the Movie API that match a given query string.
    /// - Parameters:
    ///   - query: The query string to search for.
    ///   - completion: A closure to call with the search results or an error.
    func searchMovies(query: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        // construir la URL de la API para realizar la solicitud GET
        let urlString = "\(urlBase)/3/search/movie?api_key=\(apiKey)&language=es&region=MX&query=\(query)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                completion(moviesResponse.results, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    //MARK: - Function to get movie cast
    /// Returns an array of `Cast` objects for a given movie ID by making a request to the Movie API.
    ///
    /// - Parameter idMovie: The ID of the movie to retrieve the cast for.
    /// - Returns: An array of `Cast` objects, or an empty array if an error occurs.
    func getMovieCast(idMovie: Int, completion: @escaping ([Cast]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/credits?api_key=\(apiKey)&language=es&region=MX&page=1")
        else {
            completion([])
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "cast") as? [NSDictionary]
            else {
                completion([])
                return
            }

            var castMovie: [Cast] = []

            for result in results {
                if let name = result.object(forKey: "name") as? String,
                   let profile_path = result.object(forKey: "profile_path") as? String,
                   let character = result.object(forKey: "character") as? String {
                    castMovie.append(Cast(name: name, profile_path: profile_path, character: character))
                }
            }
            DispatchQueue.main.async {
                completion(castMovie)
            }
        }
        task.resume()
    }
    
    func getReviews(idMovie: Int, completion: @escaping ([Reviews]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/reviews?api_key=\(apiKey)")
        else {
            completion([])
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }

            var reviewMovie: [Reviews] = []

            for result in results {
                if let author = result.object(forKey: "author") as? String,
                   let content = result.object(forKey: "content") as? String,
                   let created_at = result.object(forKey: "created_at") as? String {
                    reviewMovie.append(Reviews(author: author, content: content, created_at: created_at))
                }
            }
            DispatchQueue.main.async {
                completion(reviewMovie)
            }
        }
        task.resume()
    }
    
    func getSimilarMovies(idMovie: Int, completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/similar?api_key=\(apiKey)")
        else {
            completion([])
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }

            var simMovie: [Movie] = []

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    simMovie.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
                }
            }
            DispatchQueue.main.async {
                completion(simMovie)
            }
        }
        task.resume()
    }
    
    func getRecommendationsMovies(idMovie: Int, completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/recommendations?api_key=\(apiKey)")
        else {
            completion([])
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
                completion([])
                return
            }

            var simMovie: [Movie] = []

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let overview = result.object(forKey: "overview") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    simMovie.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
                }
            }
            DispatchQueue.main.async {
                completion(simMovie)
            }
        }
        task.resume()
    }

}







