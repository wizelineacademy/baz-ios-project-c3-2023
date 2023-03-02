//
//  DetailMovieRecommendationProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 17/02/23.
//

import UIKit

protocol DetailMovieRecommendationPresenterProtocol: AnyObject {
    var presenterMain: DetailMovieCellPresenterProtocol? { get set }
    var interactor: DetailMovieRecommendationInteractorInputProtocol? { get set }
    
    func getRecommendation(idMovie: Int)
    func getRecommendationCount() -> Int
    func getRecommendation(index: Int) -> Movie
    func getRecommendationImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

protocol DetailMovieRecommendationInteractorOutputProtocol: AnyObject {
    func pushRecommendation(recommendation: [Movie])
    func pushNotRecommendation()
}

protocol DetailMovieRecommendationInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieRecommendationInteractorOutputProtocol? { get set }
    var remoteDataManager: DetailMovieRecommendationRemoteDataManagerInputProtocol? { get set }
    
    func getRecommendation(idMovie: Int)
}

protocol DetailMovieRecommendationRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieRecommendationRemoteDataManagerOutputProtocol? { get set }
    
    func getRecommendation(idMovie: Int)
}

protocol DetailMovieRecommendationRemoteDataManagerOutputProtocol: AnyObject {
    func pushRecommendation(recommendation: [Movie])
    func pushNotRecommendation()
}
