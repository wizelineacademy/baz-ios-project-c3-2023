//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//

import UIKit

protocol TrendingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: TrendingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol TrendingRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createTrendingModule() -> UIViewController
}

protocol TrendingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
}

protocol TrendingInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func moviesFetched(movies: [Movie])
}

protocol TrendingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var localDatamanager: TrendingLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol TrendingDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol TrendingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol TrendingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func moviesFetched(_ movies: [Movie])
}

protocol TrendingLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
