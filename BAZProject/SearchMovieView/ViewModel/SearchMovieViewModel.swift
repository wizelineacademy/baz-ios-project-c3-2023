//
//  SearchMovieViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

protocol SearchView {
    var moviesSearch: [Movie] { get set }
}

final class SearchMovieViewModel {
    
    let movieApi = MovieAPI()
    var view: SearchView
    
    init(view: SearchView) {
        self.view = view
    }
    
    func fetchSearchMovies(query text: String) {
        movieApi.getMoviesSearch(queryMovie: text) { [weak self] moviesSearchResponse in
            self?.view.moviesSearch = moviesSearchResponse ?? []
        }
    }
}
