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
     - Returns: a closure that on success case returns a movie array otherwise an error object
     */
    func getMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let moviesList = StoredMovies.getMovies()
        else { return completion(.success([])) }
        completion(.success(moviesList.movies))
    }
}
