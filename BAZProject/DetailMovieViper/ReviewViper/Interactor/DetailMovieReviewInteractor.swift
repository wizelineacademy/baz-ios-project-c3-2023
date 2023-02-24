//
//  DetailMovieReviewInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

class DetailMovieReviewInteractor: DetailMovieReviewInteractorInputProtocol {
    
    weak var presenter: DetailMovieReviewInteractorOutputProtocol?
    var remoteDataManager: DetailMovieReviewRemoteDataManagerInputProtocol?
    
    func getReview(idMovie: Int) {
        remoteDataManager?.getReview(idMovie: idMovie)
    }
    
    
}

extension DetailMovieReviewInteractor: DetailMovieReviewRemoteDataManagerOutputProtocol {
    
    func pushReview(review: [Reviews]) {
        presenter?.pushReview(review: review)
    }
}
