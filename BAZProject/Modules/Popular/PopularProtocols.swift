//
//  PopularProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

protocol PopularViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: PopularPresenterProtocol? { get set }
    
    func reloadData()
}

protocol PopularRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createPopularModule() -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol PopularPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: PopularViewProtocol? { get set }
    var interactor: PopularInteractorInputProtocol? { get set }
    var router: PopularRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol PopularInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFetched(movies: [Movie])
}

protocol PopularInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: PopularInteractorOutputProtocol? { get set }
    var remoteDatamanager: PopularRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol PopularDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol PopularRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: PopularRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol PopularRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func moviesFetched(_ movies: [Movie])
}
