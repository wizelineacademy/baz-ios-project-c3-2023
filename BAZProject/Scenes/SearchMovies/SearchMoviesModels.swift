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
            var nextPage: Bool = false
        }
        struct Response {
            var nextPage: Bool = false
            var movies: [Movie]
        }
        struct ViewModel {
            var displayedNextPage: Bool = false
            var displayedMovies: [MovieSearch]
        }
    }
    
    enum ResetSearch {
        struct Request {
            
        }
        struct Response {
            let dataCollection: [MovieSearch]
        }
        struct ViewModel {
            let dataCollection: [MovieSearch]
        }
    }
}
