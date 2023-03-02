//
//  StoredMoviesProvider.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 14/02/23.
//

import Foundation

final class StoredMoviesProvider: MLProviderProtocol {
    /** Returns the view title */
    var viewTitle: String {
        "Peliculas vistas"
    }
    
    /** Returns the icon name */
    var iconName: String {
        "lanyardcard"
    }
    
    /**
     Get stored movies from user defaults
     - Parameters:
        - moviesData: a MoviesList object
        - completion: a closure that is called when the task is completed
     - Returns: a closure that on success case returns an updated MoviesList object,  otherwise an error object
     */
    func update(moviesData: MoviesList, completion: @escaping (Result<MoviesList, Error>) -> Void) {
        guard let storedMovies = StoredMovies.getMovies() else {
            let moviesList = MoviesList().setNextPage(with: nil)
            return completion(.success(moviesList))
        }
        let moviesList = moviesData
            .updateMovies(with: storedMovies.movies)
            .setNextPage(with: nil)
        completion(.success(moviesList))
    }
}
