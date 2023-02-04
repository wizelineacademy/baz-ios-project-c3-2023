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

    /// Returns the movies list of the category given in Mexico region and in spanish laguague.
    ///
    ///  - Parameter category: The category to be consulted
    ///  - Returns: [Movie]
    ///

    func getMovies(category: MovieAPICategory) -> [Movie] {
        guard let urlTrendingMovies = URL(string: "https://api.themoviedb.org/3/\(category.endpointUrl)?api_key=\(apiKey)&\(language)&\(region)"),
              let data = try? Data(contentsOf: urlTrendingMovies),
              let json = try? JSONDecoder().decode(MovieAPIResult.self, from: data)
        else {
            return []
        }
        return json.results
    }
    
    /// Fetch movie poster of a given url.
    ///
    ///  - Parameter url: The given image URL
    ///  - Returns: UIImage
    ///
    
    static func fetchPhoto(partialURLImage: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        if let urlImage =  URL(string: "https://image.tmdb.org/t/p/w500\(partialURLImage)"){
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
        }else{
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
        if let urlMovieDetail = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(apiKey)&\(language)&\(region)"){
            let task = URLSession.shared.dataTask(with: urlMovieDetail) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                }
                if let data = data,
                   let json = try? JSONDecoder().decode(MovieDetail.self, from: data){
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
    
}
