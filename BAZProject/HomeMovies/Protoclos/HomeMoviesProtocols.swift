//
//  HomeMoviesProtocols.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

protocol HomeMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: HomeMoviesPresenterProtocol? { get set }
    
    func reloadCollectionViewData()
    func reloadCollectionViewSearchedData()
    func catchResponse(withMessage: String?)
}

protocol HomeMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createHomeMoviesModule() -> UIViewController
    
    func goToInformationMovie(informationMovieData: InformationMovie, view: HomeMoviesViewProtocol)
}

protocol HomeMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: HomeMoviesViewProtocol? { get set }
    var interactor: HomeMoviesInteractorInputProtocol? { get set }
    var router: HomeMoviesRouterProtocol? { get set }
    var selectedCategory: MovieCategory? { get set }
    
    func loadingView()
    func getMovieCount() -> Int
    func getMovie(indexPathRow: Int) -> Movie
    
    func getSearchedMovieCount() -> Int
    func getSearchedMovie(indexPathRow: Int) -> Movie
    
    func getSearchedMovies(searchTerm: String)
    func getInformationMovie(idMovie: Int)
}

protocol HomeMoviesInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    
    func catchResponse(withMessage: String)
}

protocol HomeMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: HomeMoviesInteractorOutputProtocol? { get set }
    var remoteDatamanager: HomeMoviesRemoteDataManagerInputProtocol? { get set }
    
    func getMovies(categoryMovieType: MovieCategory)
    func getSearchedMovies(searchTerm: String)
    func getInformationMovie(idMovie: Int)
}

protocol HomeMoviesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol HomeMoviesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol? { get set }
    func getMovies(categoryMovieType: MovieCategory)
    func getSearchedMovies(searchTerm: String)
    func getInformationMovie(idMovie: Int)
}

protocol HomeMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    
    func catchResponse(withMessage: String)
}
