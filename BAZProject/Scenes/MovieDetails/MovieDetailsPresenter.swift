//
//  MovieDetailsPresenter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol MovieDetailsPresentationLogic {
    func presentLoadView(response: MovieDetails.LoadView.Response)
    func presentFechedSimilarMovies(response: MovieDetails.SimilarMovies.Response)
    func presentFechedRecommendMovies(response: MovieDetails.RecommendMovies.Response)
}

class MovieDetailsPresenter: MovieDetailsPresentationLogic {

    // MARK: Properties VIP
    weak var viewController: MovieDetailsDisplayLogic?
    
    func presentLoadView(response: MovieDetails.LoadView.Response) {
        let viewModel = MovieDetails.LoadView.ViewModel(id: response.movie.id, title: response.movie.title, imageURL: response.movie.imageURL, backdropURL: response.movie.backdropURL, overview: response.movie.overview)
        viewController?.displayView(viewModel: viewModel)
    }
    
    func presentFechedSimilarMovies(response: MovieDetails.SimilarMovies.Response) {
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "", backdropURL: movie.backdropPath ?? "", overview:    movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.SimilarMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displaySimilarMovies(viewModel: viewModel)
    }
    
    func presentFechedRecommendMovies(response: MovieDetails.RecommendMovies.Response) {
        
        let movies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "", backdropURL: movie.backdropPath ?? "", overview: movie.overview ?? "")
        }
        
        let viewModel = MovieDetails.RecommendMovies.ViewModel(idMovie: response.idMovie, movies: movies)
        
        viewController?.displayRecommendMovies(viewModel: viewModel)
    }
}
