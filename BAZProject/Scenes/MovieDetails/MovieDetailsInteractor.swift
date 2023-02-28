//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    func loadView()
    func fetchSimilarMovies(request: MovieDetails.SimilarMovies.Request)
    func fetchRecommendMovies(request: MovieDetails.RecommendMovies.Request)
}

protocol MovieDetailsDataStore: AnyObject {
    var movie: MovieSearch? { get set }
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic, MovieDetailsDataStore {
    
    // MARK: Properties VIP
    var presenter: MovieDetailsPresentationLogic?
    
    // MARK: Properties
    var movie: MovieSearch?
    var moviesWorker: MoviesWorker = MoviesWorker(movieService: MoviesAPI())
    
    func loadView() {
        guard let movie = movie else {
            return 
        }
        let response = MovieDetails.LoadView.Response(movie: movie)
        presenter?.presentLoadView(response: response)
    }
    
    func fetchSimilarMovies(request: MovieDetails.SimilarMovies.Request) {
        moviesWorker.getMoviesByType(.bySimilarMovie(id: request.idMovie)) { [weak self] movies, messageError in
            guard let self = self else {
                return
            }
            if let messageError = messageError {
                
            }
            self.presenter?.presentFechedSimilarMovies(response: MovieDetails.SimilarMovies.Response(idMovie: request.idMovie, movies: movies))
        }
    }
    
    func fetchRecommendMovies(request: MovieDetails.RecommendMovies.Request) {
        moviesWorker.getMoviesByType(.byRecommendationMovie(id: request.idMovie)) { movies, messageError in
            
            if let messageError = messageError {
                
            }
            
            let response = MovieDetails.RecommendMovies.Response(idMovie: request.idMovie, movies: movies)
            
            self.presenter?.presentFechedRecommendMovies(response: response)
        }
    }
}
