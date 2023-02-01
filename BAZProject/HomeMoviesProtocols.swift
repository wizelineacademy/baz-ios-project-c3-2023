//
//  HomeMoviesProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation
import UIKit

protocol HomeMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomeMoviesPresenterProtocol? { get set }
    
    func loadTrendingMovies()
    func loadMovies()
}

protocol HomeMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createHomeMoviesModule() -> UIViewController
}

protocol HomeMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeMoviesViewProtocol? { get set }
    var interactor: HomeMoviesInteractorInputProtocol? { get set }
    var router: HomeMoviesRouterProtocol? { get set }
    
    func getTrendingMovies()
    func getNowPlayingMovies()
    func getOneCategorieMovie(index: Int) -> Movie
    func getCategoriesMoviesCount() -> Int
    func getOneMovie(index: Int) -> Movie
    func getMoviesCount() -> Int
    func selectFilterMovies(index: Int)
    func getImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func getCategorieImage(index: Int,  completion: @escaping (UIImage?) -> Void) 
}

protocol HomeMoviesInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushTrendingMovieInfo(trendingMovies: [Movie])
    func pushNowPlayingMovieInfo(nowPlayingMovies: [Movie])
}

protocol HomeMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeMoviesInteractorOutputProtocol? { get set }
    var localDatamanager: HomeMoviesLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: HomeMoviesRemoteDataManagerInputProtocol? { get set }
    
    func getTrendingMovies()
    func getNowPlayingMovies()
}

protocol HomeMoviesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeMoviesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol? { get set }
    
    func getTrendingMovies()
    func getNowPlayingMovies()
}

protocol HomeMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushTrendingMovieInfo(trendingMovies: [Movie])
    func pushNowPlayingMovieInfo(nowPlayingMovies: [Movie])
}

protocol HomeMoviesLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
