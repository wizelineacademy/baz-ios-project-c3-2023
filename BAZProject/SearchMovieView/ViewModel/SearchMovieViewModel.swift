//
//  SearchMovieViewModel.swift
//  BAZProject
//
//  Created by nsanchezj on 02/03/23.
//

import Foundation

final class SearchMovieViewModel {
    
    let movieApi = MovieAPI()
    
    func fetchSearchMovies(query text: String) -> [Movie] {
        var moviesSearch: [Movie] = []
        movieApi.getMoviesSearch(queryMovie: text) { movies in
            moviesSearch = movies ?? []
        }
        return moviesSearch
    }
}
