//
//  SearchMoviesInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol SearchMoviesBusinessLogic: AnyObject {
    func searchMoviesBy(request: SearchMovies.FetchMovies.Request)
    func resetSearch(request: SearchMovies.ResetSearch.Request)
}

class SearchMoviesInteractor: SearchMoviesBusinessLogic {

    // MARK: Properties
    let moviesWorker = MoviesWorker(movieService: MoviesAPI())
    
    // MARK: Properties VIP
    var presenter: SearchMoviesPresenter?
    
    func searchMoviesBy(request: SearchMovies.FetchMovies.Request) {
        moviesWorker.getMoviesByType(.bySearch(request.byKeyboards), nextPage: request.nextPage) { [weak self] movies, messageError in
            self?.presenter?.presentMoviesFeched(response: SearchMovies.FetchMovies.Response(nextPage: request.nextPage, movies: movies))
        }
    }
    
    func resetSearch(request: SearchMovies.ResetSearch.Request) {
        moviesWorker.resetPagination()
        presenter?.resetCollectionData(response: SearchMovies.ResetSearch.Response(dataCollection: []))
    }
    
    
}
