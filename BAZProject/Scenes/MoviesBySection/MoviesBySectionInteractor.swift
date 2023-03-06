//
//  MoviesBySectionInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

protocol MoviesBySectionBusinessLogic: AnyObject {
    func loadView()
    func fetchMovies()
}

protocol MoviesBySectionDataStore: AnyObject {
    var section: fetchMoviesTypes? { get set }
    var movies: [MovieSearch]? { get set }
}

class MoviesBySectionInteractor: MoviesBySectionBusinessLogic, MoviesBySectionDataStore {
    
    // MARK: Properties VIP
    var presenter: MoviesBySectionPresentationLogic?

    // MARK: Properties
    var section: fetchMoviesTypes?
    var movies: [MovieSearch]?
    var moviesWorker = MoviesWorker(movieService: MoviesAPI())
    
    func loadView() {
        let response = MoviesBySection.LoadView.Response(section: section ?? .nowPlaying, movies: movies ?? [])
        presenter?.presentView(response: response)
    }
    
    func fetchMovies() {
        moviesWorker.getMoviesByType(section ?? .nowPlaying, nextPage: true) { [weak self] movies, messageError in
            guard let self = self else {
                return
            }

            self.presenter?.presentFetchedMovies(response: MoviesBySection.FetchMovies.Response(movies: movies))
        }
    }
}
