//
//  MoviesBySectionModel.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation

enum MoviesBySection{
    enum FetchMovies {
        struct Request {
        }
        struct Response {
            var movies: [Movie]
        }
        struct ViewModel {
            var movies: [MovieSearch]
        }
    }
    
    enum LoadView {
        struct Response {
            var section: fetchMoviesTypes
            var movies: [MovieSearch]
        }
        struct ViewModel {
            var title: String
            var movies: [MovieSearch]
        }
    }
}
