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
    func showNotDetailsAlert()
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
    var presenterCast: DetailMovieCastPresenterProtocol? { get set }
    var presenterReview: DetailMovieReviewPresenterProtocol? { get set }
    var presenterSimilar: DetailMovieSimilarPresenterProtocol? { get set }
    var presenterRecommendation: DetailMovieRecommendationPresenterProtocol? { get set }
    var detailsMovie: DetailMovie? { get set }
    
    func viewDidLoad()
    func getDetailImage(completion: @escaping (UIImage?) -> Void)
    func getGenres() -> String
    func getTableCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func getTableSize() -> Int
    func getTableCount() -> Int
    func getTableSize(indexPath: Int) -> CGSize
    func getCollectionCount(indexPath: Int) -> Int?
    func getCell(collectionView: UICollectionView, indexPath: IndexPath, indexPathTable: Int, nameLabel: UILabel) -> UICollectionViewCell
}

protocol DetailMovieCellPresenterProtocol: AnyObject {
    // COLLECTIONSPRESENTER -> PRESENTER
    func informSuccesfulPresenter(collectionType: CollectionTypes)
    func informErrorPresenter()
}

protocol DetailMovieInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func pushDetailMovie(detailMovie: DetailMovie)
    func pushNotDetails()
}

protocol DetailMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
    
    func getDetails(idMovie: Int)
}

protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
    
    func getDetails(idMovie: Int)
}

protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushDetailMovie(detailMovie: DetailMovie)
    func pushNotDetails()
}

