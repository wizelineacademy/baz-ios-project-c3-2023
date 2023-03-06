//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 21/02/23.
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func reloadData()
}

protocol MovieDetailRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createMovieDetailModule(of movieId: Int) -> UIViewController
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    var movieDetail: MovieDetail? { get set }
    var movieId: Int { get set }
    
    func notifyViewLoaded()
    func notifyViewAppeared()
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func movieDetailFetched(with movieDetail: MovieDetail)
}

protocol MovieDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovieDetail(of movieId: Int?)
    func notifyMovieDetailShown()
}

protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovieDetail(of movieId: Int)
}

protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func movieDetailFetched(with movieDetail: MovieDetail)
}
