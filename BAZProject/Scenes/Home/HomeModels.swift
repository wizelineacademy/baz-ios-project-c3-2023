//
//  HomeModels.swift
//  BAZProject
//
//  Created by 1034209 on 15/02/23.
//

import Foundation
import UIKit

enum Home {
    enum FetchMoviesBySection {
        struct Request {
            var section: fetchMoviesTypes
        }
        struct Response {
            var section: fetchMoviesTypes
            var movies: [Movie]
        }
        struct ViewModel {
            struct SectionWithMovies {
                var section: fetchMoviesTypes
                var movies: [MovieSearch]
            }
            var displayedMovies: SectionWithMovies
        }
    }
    
    enum GetMoviesSection {
        struct Response {
            var sections: [fetchMoviesTypes]
        }
        struct ViewModel {
            var displayedSections: [fetchMoviesTypes]
        }
    }
    
    enum SaveMovieWatched {
        struct Request {
            var movie: MovieSearch
        }
        struct Response {
            var movies: [MovieSearch]
        }
        struct ViewModel {
            var movies: [MovieSearch]
        }
    }
    
    enum ErrorFetch {
        struct Response {
            var message: String
        }
        
        struct ViewModel {
            var message: String
        }
    }
}
