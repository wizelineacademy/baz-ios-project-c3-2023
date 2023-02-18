//
//  DetailMovieReviewRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieReviewRemoteDataManager: DetailMovieReviewRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailMovieReviewRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getReview(idMovie: Int?) {
        guard let idMovie = idMovie else { return }
        let urlReviewMovie = "https://api.themoviedb.org/3/movie/\(idMovie)/reviews?api_key=\(apiKey)"
        movieApi.getReviews(for: urlReviewMovie) { review in
            guard let review = review else {
                return
            }
            self.remoteRequestHandler?.pushReview(review: review)
        }
    }
    
    
}
