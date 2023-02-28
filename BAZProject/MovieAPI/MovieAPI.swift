//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let language: String = "language=es"
    private let region = "region=MX"
    
    enum consult: String {
        case similar
        case recommendations
    }

    /// Returns the movies list of the category given in Mexico region and in spanish laguague.
    ///
    ///  - Parameter category: The category to be consulted
    ///  - Returns: T object.
    ///
    
    struct URLSessionFetcher {
        
        private let urlRequestFactory: URLRequestFactory
        private let decodableResultAdapter: DecodableResultAdapter
        private struct DataNotFoundError: Error { }
        
        init(urlRequestFactory: URLRequestFactory, decodableResultAdapter: DecodableResultAdapter) {
            self.urlRequestFactory = urlRequestFactory
            self.decodableResultAdapter = decodableResultAdapter
        }
        
        func fetchData<T: Decodable>(completionHandler: @escaping (T?, Error?) -> Void) {
            let urlRequest = urlRequestFactory.makeUrlRequest()
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                } else {
                    guard let data = data
                    else {
                        completionHandler(nil, DataNotFoundError()); return
                    }
                    let movieResult: (T?, Error?) = self.decodableResultAdapter.mapToResult(with: data)
                    completionHandler(movieResult.0, movieResult.1)
                }
            }
            task.resume()
        }
    }
    
    /// Fetch movie poster of a given url.
    ///
    ///  - Parameter url: The given image URL
    ///  - Returns: UIImage
    ///
    
    static func fetchPhoto(partialURLImage: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        if let urlImage =  URL(string: "https://image.tmdb.org/t/p/w500\(partialURLImage)") {
            let task = URLSession.shared.dataTask(with: urlImage) { (data, response, error) in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data, let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    if let imageToShow = UIImage(data: data) {
                        DispatchQueue.main.async {
                            completionHandler(imageToShow, nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            completionHandler(UIImage(named: "poster"), nil)
                        }
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(UIImage(named: "poster"), nil)
        }
    }
    
    /// Returns the movie detail of the id movie given.
    ///
    ///  - Parameter movieID: The given id movie.
    ///  - Returns: MovieDetail
    ///
    ///

    func getMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetail?, Error?) -> Void) {
        if let urlMovieDetail = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&\(language)&\(region)") {
            let task = URLSession.shared.dataTask(with: urlMovieDetail) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let json = try? JSONDecoder().decode(MovieDetail.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(json, nil)
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
    
    /// Returns the cast of a movie given.
    ///
    ///  - Parameter movieID: The given id movie.
    ///  - Returns: MovieAPICast
    ///
    ///
    
    func getMovieCast(movieID: Int, completionHandler: @escaping(MovieAPICast?, Error?) -> Void) {
        if let urlMovieCast = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)&\(language)&\(region)") {
            let task = URLSession.shared.dataTask(with: urlMovieCast) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let cast = try?  JSONDecoder().decode(MovieAPICast.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(cast, nil)
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
    
    /// Returns recommendations or similar movies from movie given.
    ///
    ///  - Parameter movieID: The given id movie.
    ///              queryType: recomendation or similar.
    ///  - Returns: [Movie]?
    ///
    ///

    func getMovies(movieID: Int, queryType: MovieAPI.consult, completionHandler: @escaping([Movie]?, Error?) -> Void) {
        if let urlSimilarMovies = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/\(queryType)?api_key=\(apiKey)&\(language)&\(region)") {
            let task = URLSession.shared.dataTask(with: urlSimilarMovies) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let result =  try? JSONDecoder().decode(MovieAPIResult.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(result.results, nil )
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
    
    /// Returns reviews from movie given.
    ///
    ///  - Parameter movieID: The given id movie.
    ///  - Returns: [Movie]?
    ///
    ///

    func getMovieReviews(movieID: Int, completionHandler: @escaping([MovieReview]?, Error?) -> Void) {
        if let urlSimilarMovies = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/reviews?api_key=\(apiKey)") {
            let task = URLSession.shared.dataTask(with: urlSimilarMovies) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let result =  try? JSONDecoder().decode(MovieAPIReviews.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(result.results, nil )
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }

    /// Returns movies from a text given.
    ///
    ///  - Parameter movieID: The text given to search movies.
    ///  - Returns: [Movie]?
    ///

    func searchMovie(textEncoded: String, completionHandler: @escaping([Movie]?, Error?) -> Void) {
        let textEncoded = textEncoded.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)        
        if  let textEncoded = textEncoded,
            let urlSimilarMovies = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&\(language)&\(region)&query=\(textEncoded)") {
            let task = URLSession.shared.dataTask(with: urlSimilarMovies) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let result =  try? JSONDecoder().decode(MovieAPIResult.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(result.results, nil )
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
    
    /// Returns keywords from a text given.
    ///
    ///  - Parameter movieID: The text given to search movies.
    ///  - Returns: [Movie]?
    ///

    func searchKeywords(textEncoded: String, completionHandler: @escaping([MovieKeyword]?, Error?) -> Void) {
        let textEncoded = textEncoded.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if  let textEncoded = textEncoded,
            let urlSimilarMovies = URL(string: "https://api.themoviedb.org/3/search/keyword?api_key=\(apiKey)&page=1&query=\(textEncoded)") {
            let task = URLSession.shared.dataTask(with: urlSimilarMovies) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let result =  try? JSONDecoder().decode(MovieAPIKeyword.self, from: data) {
                    DispatchQueue.main.async {
                        completionHandler(result.results, nil )
                    }
                }
            }
            task.resume()
        } else {
            completionHandler(nil, nil)
        }
    }
}
