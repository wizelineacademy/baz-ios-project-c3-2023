//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

final class MovieAPI {
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let urlBase: String = "https://api.themoviedb.org/3"
    
    
    /**
     obtains array movies from Api
     - Parameter typeMovie: Is a enum for type movie
     - Returns: An array type Movie
     */
    
    func getMovies(typeMovie: TypeMovieList, completion: @escaping(([Movie]?) -> Void)) {
        guard let url = URL(string: "\(urlBase)/movie/\(typeMovie.getOptionMovie())?api_key=\(apiKey)&page=1") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data{
                do{
                    let results = try JSONDecoder().decode(ReponseMovies.self, from: data)
                    completion(results.results)
                }catch{
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /**
     obtains detail movie from Api
     - Parameter idMovie: Is an id movie for each movie
     - Returns: A estruct MovieDetail with more info about movie
     */
    
    func getDetailMovie(idMovie: Int, completion: @escaping((MovieDetail?) -> Void)) {
        guard let url = URL(string: "\(urlBase)/movie/\(idMovie))?api_key=\(apiKey)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    /**
     obtains specific list movies by browser
     - Parameter queryMovie: search word movie
     - Returns: An array type Movie
     */
    
    func getMoviesSearch(queryMovie: String, completion: @escaping(([Movie]?) -> Void)) {        
        guard let url = URL(string: "\(urlBase)/search/movie?api_key=\(apiKey)&query=\(queryMovie)") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let data = data{
                do{
                    let result = try JSONDecoder().decode(ReponseMovies.self, from: data)
                    completion(result.results)
                }catch{
                    completion(nil)
                }
                
            } else {
                completion(nil)
            }
        }
        task.resume()
        
    }
}


