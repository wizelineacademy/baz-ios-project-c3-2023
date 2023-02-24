//
//  SearchingProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

protocol SearchingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol SearchingRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createSearchingModule() -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol SearchingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchingViewProtocol? { get set }
    var interactor: SearchingInteractorInputProtocol? { get set }
    var router: SearchingRouterProtocol? { get set }
    var searchResults: [SearchResult]? { get set }
    
    func searchMovies(with query: String?)
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol SearchingInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    
    func searchResultsFecthed(searchResults: [SearchResult])
}

protocol SearchingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchingInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol? { get set }
    
    func fetchSearchResults(with query: String)
}

protocol SearchingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchSearchResults(with query: String)
}

protocol SearchingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    
    func searchResultsFecthed(searchResults: [SearchResult])
}
