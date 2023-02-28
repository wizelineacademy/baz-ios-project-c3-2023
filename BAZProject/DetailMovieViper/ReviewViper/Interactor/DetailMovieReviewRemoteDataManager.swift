//
//  DetailMovieReviewRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieReviewRemoteDataManager: DetailMovieReviewRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailMovieReviewRemoteDataManagerOutputProtocol?
    
    private let movieApi : MovieAPI = MovieAPI()
    
    func getReview(idMovie: Int) {
        if let url = URLBuilder.getUrl(urlType: .reviews(idMovie)) {
            movieApi.getReviews(for: url) { [weak self] review in
                guard let review = review else {
                    self?.remoteRequestHandler?.pushNotReview()
                    return
                }
                self?.remoteRequestHandler?.pushReview(review: review)
            }
        }
    }
}
