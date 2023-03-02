//
//  NowPlayingProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

protocol NowPlayingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: NowPlayingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol NowPlayingRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createNowPlayingModule() -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol NowPlayingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: NowPlayingViewProtocol? { get set }
    var interactor: NowPlayingInteractorInputProtocol? { get set }
    var router: NowPlayingRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol NowPlayingInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func moviesFetched(movies: [Movie])
}

protocol NowPlayingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: NowPlayingInteractorOutputProtocol? { get set }
    var remoteDatamanager: NowPlayingRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol NowPlayingDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol NowPlayingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: NowPlayingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol NowPlayingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func moviesFetched(_ movies: [Movie])
}
