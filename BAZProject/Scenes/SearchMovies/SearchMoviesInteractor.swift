//
//  SearchMoviesInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol SearchMoviesBusinessLogic: AnyObject {
    func searchMoviesBy(words: String)
}

class SearchMoviesInteractor: SearchMoviesBusinessLogic {
    
    // MARK: Properties
    let moviesWorker = MoviesWorker(movieService: MoviesAPI())
    
    // MARK: Properties VIP
    var presenter: SearchMoviesPresenter?
    
    func searchMoviesBy(words: String) {
        moviesWorker.getMoviesByType(.bySearch(words)) { movies, messageError in
            print(movies)
        }
    }
}
