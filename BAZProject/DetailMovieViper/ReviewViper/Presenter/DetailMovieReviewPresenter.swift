//
//  DetailMovieReviewPresenter.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieReviewPresenter: DetailMovieReviewPresenterProtocol {
    
    var presenterMain: DetailMovieReviewProtocol?
    var interactor: DetailMovieReviewInteractorInputProtocol?
    var review: [Reviews] = []
    
    /// Get the review of the movie
    ///
    /// - Parameter idMovie: integer that represents the id of the movie
    func getReview(idMovie: Int) {
        interactor?.getReview(idMovie: idMovie)
    }
    
    /// Get the review count of the movie
    ///
    /// - Returns: integer that represents the count of the review
    func getReviewCount() -> Int {
        return review.count
    }
    
    /// Get the review of the movie
    ///
    /// - Parameter index: integer that represents the index of the review
    /// - Returns: return the review object of the index
    func getReview(index: Int) -> Reviews {
        return review[index]
    }
    
    
}

extension DetailMovieReviewPresenter: DetailMovieReviewInteractorOutputProtocol {
    
    func pushReview(review: [Reviews]) {
        self.review = review
    }
}
