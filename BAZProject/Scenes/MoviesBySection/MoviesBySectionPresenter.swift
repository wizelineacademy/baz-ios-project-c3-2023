//
//  MoviesBySectionPresenter.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

protocol MoviesBySectionPresentationLogic: AnyObject {
    func presentView(response: MoviesBySection.LoadView.Response)
    func presentFetchedMovies(response: MoviesBySection.FetchMovies.Response)
}

class MoviesBySectionPresenter: MoviesBySectionPresentationLogic {
    var viewController: MoviesBySectionDisplayLogic?
    
    func presentView(response: MoviesBySection.LoadView.Response) {
   
        let viewModel = MoviesBySection.LoadView.ViewModel(title: response.section.title, movies: response.movies)
        
        viewController?.displayView(viewModel: viewModel)
    }
    
    func presentFetchedMovies(response: MoviesBySection.FetchMovies.Response) {
        let displayedMovies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "")
        }
        let viewModel = MoviesBySection.FetchMovies.ViewModel(movies: displayedMovies)
        viewController?.displayFetchedMovies(viewModel: viewModel)
    }
}
