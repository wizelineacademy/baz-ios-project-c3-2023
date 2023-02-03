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

    func getMovies(typeMovie: TypeMovie) -> [Movie]? {
        guard let url = URL(string: "\(urlBase)/movie/\(typeMovie.getOptionMovie())?api_key=\(apiKey)"),
              let data = try? Data(contentsOf: url),
              let responseMovies = try? JSONDecoder().decode(ReponseMovies.self, from: data)
        else {
            return nil
        }
        return responseMovies.results
    }
    
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


