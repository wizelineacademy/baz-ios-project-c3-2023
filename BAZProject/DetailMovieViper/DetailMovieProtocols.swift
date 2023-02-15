//
//  DetailMovieProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation
import UIKit

protocol DetailMovieViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: DetailMoviePresenterProtocol? { get set }
    func setupDetailsView()
    func reloadView()
}

protocol DetailMovieRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createDetailMovieModule(idMovie: Int) -> UIViewController
}

protocol DetailMoviePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    var idMovie: Int? { get set }
    var detailsMovie: DetailMovie? { get set }
    
    func viewDidLoad()
    func getDetailImage(completion: @escaping (UIImage?) -> Void)
    func getTableSize() -> Int
    func getTableCout() -> Int
    func getCastCount() -> Int
    func getCast(index: Int) -> Cast
    func getReviewCount() -> Int
    func getReview(index: Int) -> Reviews
    func getCastImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func getSimilarCount() -> Int
    func getSimilarImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func getRecommendationCount() -> Int
    func getRecommendationImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

protocol DetailMovieInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func pushDetailMovie(detailMovie: DetailMovie)
    func pushCast(cast: [Cast])
    func pushNotCast()
    func pushReviews(reviews: [Reviews])
    func pushNotRewiews()
    func pushSimilar(similar: [Movie])
    func pushNotSimilar()
    func pushRecommendations(recommendations: [Movie])
    func pushNotRecommentations()
}

protocol DetailMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
    
    func getDetails(idMovie: Int?)
    func getCast(idMovie: Int?)
    func getReviews(idMovie: Int?)
    func getSimilar(idMovie: Int?)
    func getRecommendations(idMovie: Int?)
}

protocol DetailMovieDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
    
    func getDetails(idMovie: Int?)
    func getCast(idMovie: Int?)
    func getReviews(idMovie: Int?)
    func getSimilar(idMovie: Int?)
    func getRecommendations(idMovie: Int?)
}

protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func pushDetailMovie(detailMovie: DetailMovie)
    func pushCast(cast: [Cast])
    func pushNotCast()
    func pushReviews(reviews: [Reviews])
    func pushNotRewiews()
    func pushSimilar(similar: [Movie])
    func pushNotSimilar()
    func pushRecommendations(recommendations: [Movie])
    func pushNotRecommentations()
}

protocol DetailMovieLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
