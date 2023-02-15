//
//  DetailMovieRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation

class DetailMovieRemoteDataManager:DetailMovieRemoteDataManagerInputProtocol {
 
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getDetails(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlDetailMovie = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=\(apiKey)"
        movieApi.getDetails(for: urlDetailMovie) { detailMovie in
            guard let detailMovie = detailMovie else { return }
            self.remoteRequestHandler?.pushDetailMovie(detailMovie: detailMovie)
        }
    }
    
    func getCast(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlCastMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/credits?api_key=\(apiKey)"
        movieApi.getCast(for: urlCastMovie) { cast in
            guard let cast = cast else {
                self.remoteRequestHandler?.pushNotCast()
                return
            }
            self.remoteRequestHandler?.pushCast(cast: cast)
        }
    }
    
    func getReviews(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlReviewMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/reviews?api_key=\(apiKey)"
        movieApi.getReviews(for: urlReviewMovie) { reviews in
            guard let reviews = reviews else {
                self.remoteRequestHandler?.pushNotRewiews()
                return
            }
            self.remoteRequestHandler?.pushReviews(reviews: reviews)
        }
    }
    
    func getSimilar(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlSimilarMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/similar?api_key=\(apiKey)"
        movieApi.getMovies(for: urlSimilarMovie) { similar in
            guard let similar = similar else {
                self.remoteRequestHandler?.pushNotSimilar()
                return
            }
            self.remoteRequestHandler?.pushSimilar(similar: similar)
        }
    }
    
    func getRecommendations(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlRecommendations = "https://api.themoviedb.org/3/movie/\(idMovie)/recommendations?api_key=\(apiKey)"
        movieApi.getMovies(for: urlRecommendations) { recommendations in
            guard let recommendations = recommendations else {
                self.remoteRequestHandler?.pushNotRecommentations()
                return
            }
            self.remoteRequestHandler?.pushRecommendations(recommendations: recommendations)
        }
    }
    
    
}
