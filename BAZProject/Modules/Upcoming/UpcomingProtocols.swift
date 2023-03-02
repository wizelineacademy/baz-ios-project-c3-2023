//
//  UpcomingProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

protocol UpcomingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: UpcomingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol UpcomingRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createUpcomingModule() -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol UpcomingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: UpcomingViewProtocol? { get set }
    var interactor: UpcomingInteractorInputProtocol? { get set }
    var router: UpcomingRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol UpcomingInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFetched(movies: [Movie])
}

protocol UpcomingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: UpcomingInteractorOutputProtocol? { get set }
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol UpcomingDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol UpcomingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: UpcomingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol UpcomingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func moviesFetched(_ movies: [Movie])
}
