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
    
    func getMovies(typeMovie: TypeMovieList) -> [Movie]? {
        guard let url = URL(string: "\(urlBase)/movie/\(typeMovie.getOptionMovie())?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let responseMovies = try? JSONDecoder().decode(ReponseMovies.self, from: data)
        else {
            return nil
        }
        return responseMovies.results
    }
    
    /**
     obtains detail movie from Api
     - Parameter idMovie: Is an id movie for each movie
     - Returns: A estruct MovieDetail with more info about movie
     */
    
    func getDetailMovie(idMovie : Int) -> MovieDetail? {
        guard let url = URL(string: "\(urlBase)/movie/\(idMovie))?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let responseDetailMovie = try? JSONDecoder().decode(MovieDetail.self, from: data)
        else {
            return nil
        }
        
        return responseDetailMovie
    }
}


