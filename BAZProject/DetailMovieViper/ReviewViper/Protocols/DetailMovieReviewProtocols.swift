//
//  DetailMovieReviewProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import Foundation

protocol DetailMovieReviewPresenterProtocol: AnyObject {
    var presenterMain: DetailMovieReviewProtocol? { get set }
    var interactor: DetailMovieReviewInteractorInputProtocol? { get set }
    
    func getReview(idMovie: Int)
    func getReviewCount() -> Int
    func getReview(index: Int) -> Reviews
}

protocol DetailMovieReviewInteractorOutputProtocol: AnyObject {
    func pushReview(review: [Reviews])
    func pushNotReview()
}

protocol DetailMovieReviewInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieReviewInteractorOutputProtocol? { get set }
    var remoteDataManager: DetailMovieReviewRemoteDataManagerInputProtocol? { get set }
    
    func getReview(idMovie: Int)
}

protocol DetailMovieReviewRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieReviewRemoteDataManagerOutputProtocol? { get set }
    
    func getReview(idMovie: Int)
}

protocol DetailMovieReviewRemoteDataManagerOutputProtocol: AnyObject {
    func pushReview(review: [Reviews])
    func pushNotReview()
}
