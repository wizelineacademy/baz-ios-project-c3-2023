//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

/**
 The delegate for `MovieAPIManager` that receives a list of `Movie` objects.
 */
protocol MovieAPIManagerDelegate: AnyObject {
    func didReceiveMovies<T: Codable>(_ movies: T)
}

class MovieAPI {
    weak var delegate: MovieAPIManagerDelegate?
    private let apiKey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let urlBase = "https://api.themoviedb.org"
    
    //MARK: - Private Functions
    /// Fetches a list of movies from a given URL.
    /// - Parameter url: The URL from which to fetch the movies.
    /// - Parameter completion: A completion handler to be called when the movies have been fetched. Receives an array of `Movie` objects as a parameter.
    private func getMovies(from url: URL, completion: @escaping ([Movie]) -> Void) {
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
    
    //MARK: - Public Functions - Functions to get movie details
    /**
     Fetches a list of trending movies using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     */
    func getTrendingMovies() {
        guard let url = URL(string: "\(urlBase)/3/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    /**
     Fetches a list of now playing movies using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     */
    func getNowPlayingMovies() {
        guard let url = URL(string: "\(urlBase)/3/movie/now_playing?api_key=\(apiKey)&language=es&region=MX&page=1") else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    
    /**
     Fetches a list of popular movies using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     */
    func getPopularMovies() {
        guard let url = URL(string: "\(urlBase)/3/movie/popular?api_key=\(apiKey)") else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    
    /**
     Fetches a list of upcoming movies using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     */
    func getUpcomingMovies() {
        guard let url = URL(string: "\(urlBase)/3/movie/upcoming?api_key=\(apiKey)") else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    
    /**
     Fetches a list of rated movies using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     */
    func getRatedMovies() {
        guard let url = URL(string: "\(urlBase)/3/movie/top_rated?api_key=\(apiKey)") else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    
    /** Fetches a list of movies that are similar to the given movie ID using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     - Parameters:
     - idMovie: The ID of the movie to find similar movies for.
     */
    func getSimilarMovies(idMovie: Int) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/similar?api_key=\(apiKey)")
        else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
    }
    
    /**
     Fetches a list of recommended movies based on the given movie ID using the `getMovies` function and calls the `didReceiveMovies` method of the delegate with the result.
     - Parameters:
     - idMovie: The ID of the movie to find recommended movies for.
     */
    func getRecommendationsMovies(idMovie: Int) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/recommendations?api_key=\(apiKey)")
        else {
            return
        }
        getMovies(from: url) { movies in
            self.delegate?.didReceiveMovies(movies)
        }
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
    func getMovieCast(idMovie: Int) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/credits?api_key=\(apiKey)&language=es&region=MX&page=1")
        else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "cast") as? [NSDictionary]
            else {
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
                self.delegate?.didReceiveMovies(castMovie)
            }
        }
        task.resume()
    }
  
    //MARK: - Function to get movie reviews
    /// Returns an array of `Reviews` objects for a given movie ID by making a request to the Movie API.
    ///
    /// - Parameter idMovie: The ID of the movie to retrieve the reviews for.
    /// - Returns: An array of `Reviews` objects, or an empty array if an error occurs.
    func getReviewsMovies(idMovie: Int) {
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/reviews?api_key=\(apiKey)")
        else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else {
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
                self.delegate?.didReceiveMovies(reviewMovie)
            }
        }
        task.resume()
    }
}
