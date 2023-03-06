//
//  MovieDetailsPresenter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsPresentationLogic {
    func presentLoadView(response: MovieDetails.LoadView.Response)
    func presentFechedSimilarMovies(response: MovieDetails.FetchSimilarMovies.Response)
    func presentFechedRecommendMovies(response: MovieDetails.FetchRecommendMovies.Response)
    func presentFechedCast(response: MovieDetails.FetchCast.Response)
    func presentFetchedReview(response: MovieDetails.FetchReview.Response)
    func presentErrorMessage(response: MovieDetails.ErrorDisplay.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {

    // MARK: Properties VIP
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentLoadView(response: MovieDetails.LoadView.Response) {
        let viewModel = MovieDetails.LoadView.ViewModel(movie: response.movie)
        viewController?.displayView(viewModel: viewModel)
    }
    
    func presentFechedSimilarMovies(response: MovieDetails.FetchSimilarMovies.Response) {
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", name: movie.title ?? "", description:    movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.FetchSimilarMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displaySimilarMovies(viewModel: viewModel)
    }
    
    func presentFechedRecommendMovies(response: MovieDetails.FetchRecommendMovies.Response) {
        
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", name: movie.title ?? "", description: movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.FetchRecommendMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displayRecommendMovies(viewModel: viewModel)
    }
    
    func presentFechedCast(response: MovieDetails.FetchCast.Response) {
        
        let cast = response.cast.map { cast in
            CastSearch(id: cast.id ?? -1, imageURL: cast.profilePath ?? "", name: cast.name ?? "", description: cast.character ?? "")
        }
        
        let viewModel = MovieDetails.FetchCast.ViewModel(idMovie: response.idMovie, cast: cast)
        viewController?.displayCast(viewModel: viewModel)
    }
    
    func presentFetchedReview(response: MovieDetails.FetchReview.Response) {
        
        let viewModel = MovieDetails.FetchReview.ViewModel(idMovie: response.idMovie, review: response.review)
        
        viewController?.displayReview(viewModel: viewModel)
    }
    
    func presentErrorMessage(response: MovieDetails.ErrorDisplay.Response) {
        let viewModel = MovieDetails.ErrorDisplay.ViewModel(message: response.message)
        viewController?.displayAlertError(viewModel: viewModel)
    }
}
