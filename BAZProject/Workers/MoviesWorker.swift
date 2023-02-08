//
//  MoviesWorker.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

class MoviesWorker {    
    var movieService: MovieServicesProtocol
    
    init(movieService: MovieServicesProtocol) {
        self.movieService = movieService
    }
    
    func getMoviesByType(_ type: fetchMoviesTypes, completionHandler: @escaping ([Movie], String?) -> Void) {
        movieService.fetchMovies(type: type) { movies, error in
            if let error = error {
                completionHandler([], error.localizedDescription.description)
            }
            completionHandler(movies, nil)
        }
    }
    
    func getReviewsByMovieId(_ id: Int, completionHandler: @escaping ([Review], String?) -> Void) {
        movieService.fetchReviews(id: id) { reviews, error in
            if let error = error {
                completionHandler([], error.localizedDescription.description)
            }
            completionHandler(reviews, nil)
        }
    }
}
