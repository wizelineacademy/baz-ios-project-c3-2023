//
//  SearchMoviesModels.swift
//  BAZProject
//
//  Created by 1034209 on 19/02/23.
//

import Foundation

enum SearchMovies {
    enum FetchMovies {
        struct Request {
            var byKeyboards: String
        }
        struct Response {
            var movies: [Movie]
        }
        struct ViewModel {

            var displayedMovies: [MovieSearch]
        }
    }
}
