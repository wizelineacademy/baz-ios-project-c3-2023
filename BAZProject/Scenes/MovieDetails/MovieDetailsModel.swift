//
//  MovieDetailsModel.swift
//  BAZProject
//
//  Created by 1034209 on 23/02/23.
//

import Foundation

enum MovieDetails {
    enum LoadView {
        struct Response {
            var movie: MovieSearch
        }
        struct ViewModel {
            var id: Int
            var title: String
            var imageURL: String
            var backdropURL: String
            var overview: String
        }
    }
    
    enum SimilarMovies {
        struct Request {
            var idMovie: Int
        }
        struct Response {
            var idMovie: Int
            var movies: [Movie]
        }
        struct ViewModel {
            var idMovie: Int
            var movies: [MovieSearch]
        }
    }
}
