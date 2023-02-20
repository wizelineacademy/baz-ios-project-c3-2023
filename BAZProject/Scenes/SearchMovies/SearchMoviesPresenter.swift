//
//  SearchMoviesPresenter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

protocol SearchMoviesPresentationLogic: AnyObject {
    func presentMoviesFeched(response: SearchMovies.FetchMovies.Response)
}

class SearchMoviesPresenter: SearchMoviesPresentationLogic {
    
    // MARK: Properties VIP
    weak var viewController: SearchMoviesDisplayLogic?
    
    func presentMoviesFeched(response: SearchMovies.FetchMovies.Response) {
        let displayedMovies = response.movies.map { movie in
            return MovieSearch(id: movie.id ?? -1, imageURL: movie.posterPath ?? "", title: movie.title ?? "")
        }
        viewController?.displayFetchMovies(viewModel: SearchMovies.FetchMovies.ViewModel(displayedMovies: displayedMovies))
    }
}
