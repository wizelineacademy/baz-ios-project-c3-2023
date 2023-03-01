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
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {

    // MARK: Properties VIP
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentLoadView(response: MovieDetails.LoadView.Response) {
        let viewModel = MovieDetails.LoadView.ViewModel(id: response.movie.id, title: response.movie.title, imageURL: response.movie.imageURL, backdropURL: response.movie.backdropURL, overview: response.movie.overview)
        viewController?.displayView(viewModel: viewModel)
    }
    
    func presentFechedSimilarMovies(response: MovieDetails.FetchSimilarMovies.Response) {
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "", backdropURL: movie.backdropPath ?? "", overview:    movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.FetchSimilarMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displaySimilarMovies(viewModel: viewModel)
    }
    
    func presentFechedRecommendMovies(response: MovieDetails.FetchRecommendMovies.Response) {
        
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "", backdropURL: movie.backdropPath ?? "", overview: movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.FetchRecommendMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displayRecommendMovies(viewModel: viewModel)
    }
    
    func presentFechedCast(response: MovieDetails.FetchCast.Response) {
        let viewModel = MovieDetails.FetchCast.ViewModel(idMovie: response.idMovie, cast: response.cast)
        viewController?.displayCast(viewModel: viewModel)
    }
}
