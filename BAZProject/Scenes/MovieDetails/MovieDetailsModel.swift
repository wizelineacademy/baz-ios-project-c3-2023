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
            var movie: MovieSearch
        }
    }
    
    enum FetchSimilarMovies {
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
    
    enum FetchRecommendMovies {
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
    
    enum FetchCast {
        struct Request {
            var idMovie: Int
        }
        struct Response {
            var idMovie: Int
            var cast: [Cast]
        }
        struct ViewModel {
            var idMovie: Int
            var cast: [CastSearch]
        }
    }
    
    enum FetchReview {
        struct Request {
            var idMovie: Int
        }
        struct Response {
            var idMovie: Int
            var review: Review?
        }
        struct ViewModel {
            var idMovie: Int
            var review: Review?
        }
    }
    
    enum PostMovieWatchNotification {
        struct Request {
            var movie: MovieSearch
        }
    }
}
