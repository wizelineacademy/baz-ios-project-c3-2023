//
//  TopRatedProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//

import UIKit

protocol TopRatedViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: TopRatedPresenterProtocol? { get set }
    
    func reloadData()
}

protocol TopRatedRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createTopRatedModule() -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol TopRatedPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: TopRatedViewProtocol? { get set }
    var interactor: TopRatedInteractorInputProtocol? { get set }
    var router: TopRatedRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol TopRatedInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFetched(movies: [Movie])
}

protocol TopRatedInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: TopRatedInteractorOutputProtocol? { get set }
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol TopRatedDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol TopRatedRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: TopRatedRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol TopRatedRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func moviesFetched(_ movies: [Movie])
}
