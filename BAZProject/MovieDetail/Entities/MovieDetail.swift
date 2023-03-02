//
//  DetailMovie.swift
//  BAZProject
//
//  Created by hlechuga on 17/02/23.
//

import Foundation

struct MovieDetail {
    let movie: Movie
    let credits: Credits
    let reviews: Reviews
    let similarMovies: SimilarMovies
    let recomendtions: SimilarMovies
}

enum MovieDetailType {
    
    case moviePoster(Movie)
    case movieReview(Movie)
    case credits(Credits)
    case reviews(Reviews)
    case similarMovies(SimilarMovies)
    case recomendations(SimilarMovies)
    
    func value() -> Any? {
        switch self {
        case .moviePoster(let movie):
            return movie
        case .movieReview(let movie):
            return movie
        case .credits(let credits):
            return credits
        case .reviews(let reviews):
            return reviews
        case .similarMovies(let similarMovies):
            return similarMovies
        case .recomendations(let similarMovies):
            return similarMovies
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .moviePoster :
            return ""
        case .movieReview :
            return "Reseña"
        case .credits :
            return "Reparto"
        case .reviews :
            return "Reseñas de la película"
        case .similarMovies :
            return "Peliculas Similares"
        case .recomendations :
            return "Peliculas Recomendadas"
        }
    }
    
    func getHeight() -> Double {
        switch self {
        case .moviePoster :
            return 300.0
        case .movieReview :
            return 200.0
        case .credits :
            return 150.0
        case .reviews :
            return 200.0
        case .similarMovies, .recomendations :
            return 250.0
        }
    }
}
