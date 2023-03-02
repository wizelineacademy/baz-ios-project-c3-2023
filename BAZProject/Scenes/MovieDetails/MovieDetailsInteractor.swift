//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsBusinessLogic: AnyObject {
    func loadView()
    func fetchSimilarMovies(request: MovieDetails.FetchSimilarMovies.Request)
    func fetchRecommendMovies(request: MovieDetails.FetchRecommendMovies.Request)
    func fetchCast(request: MovieDetails.FetchCast.Request)
    func fetchReview(request: MovieDetails.FetchReview.Request)
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
    
    func fetchSimilarMovies(request: MovieDetails.FetchSimilarMovies.Request) {
        moviesWorker.getMoviesByType(.bySimilarMovie(id: request.idMovie)) { [weak self] movies, messageError in
            if let messageError = messageError {
                
            }
            self?.presenter?.presentFechedSimilarMovies(response: MovieDetails.FetchSimilarMovies.Response(idMovie: request.idMovie, movies: movies))
        }
    }
    
    func fetchRecommendMovies(request: MovieDetails.FetchRecommendMovies.Request) {
        moviesWorker.getMoviesByType(.byRecommendationMovie(id: request.idMovie)) { movies, messageError in
            
            if let messageError = messageError {
                
            }
            
            let response = MovieDetails.FetchRecommendMovies.Response(idMovie: request.idMovie, movies: movies)
            
            self.presenter?.presentFechedRecommendMovies(response: response)
        }
    }
    
    func fetchCast(request: MovieDetails.FetchCast.Request) {
        moviesWorker.getCastsByMovieId(request.idMovie) { cast, messageError in
            if let messageError = messageError {
                
            }
            let response = MovieDetails.FetchCast.Response(idMovie: request.idMovie, cast: Array(cast.prefix(10)))
            
            self.presenter?.presentFechedCast(response: response)
        }
    }
    
    func fetchReview(request: MovieDetails.FetchReview.Request) {
        moviesWorker.getReviewsByMovieId(request.idMovie) { reviews, messageError in
            if let messageError = messageError {
                
            }
            
            let response = MovieDetails.FetchReview.Response(idMovie: request.idMovie, review: reviews.first)
            
            self.presenter?.presentFetchedReview(response: response)
        }
    }
}
