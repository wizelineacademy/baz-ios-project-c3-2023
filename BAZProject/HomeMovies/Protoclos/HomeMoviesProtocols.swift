//
//  HomeMoviesProtocols.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

protocol HomeMoviesViewProtocol: AnyObject {
    // Presenter -> View
    var presenter: HomeMoviesPresenterProtocol? { get set }
    
    func reloadCollectionViewData()
    func reloadCollectionViewSearchedData()
    func catchResponse(withMessage: String?)
}

protocol HomeMoviesRouterProtocol: AnyObject {
    // Presenter -> Router
    static func createHomeMoviesModule() -> UIViewController
    
    func goToInformationMovie(informationMovieData: InformationMovie, view: HomeMoviesViewProtocol)
}

protocol HomeMoviesPresenterProtocol: AnyObject {
    // View -> Presenter
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
    // Interactor -> Presenter
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    
    func catchResponse(withMessage: String)
}

protocol HomeMoviesInteractorInputProtocol: AnyObject {
    // Presenter -> Interactor
    var presenter: HomeMoviesInteractorOutputProtocol? { get set }
    var remoteDatamanager: HomeMoviesRemoteDataManagerInputProtocol? { get set }
    
    func getMovies(categoryMovieType: MovieCategory)
    func getSearchedMovies(searchTerm: String)
    func getInformationMovie(idMovie: Int)
}

protocol HomeMoviesRemoteDataManagerInputProtocol: AnyObject {
    // Interactor -> RemoteDataManager
    var remoteRequestHandler: HomeMoviesRemoteDataManagerOutputProtocol? { get set }
    func getMovies(categoryMovieType: MovieCategory)
    func getSearchedMovies(searchTerm: String)
    func getInformationMovie(idMovie: Int)
}

protocol HomeMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // RemoteDataManager -> Interactor
    func pushMoviesData(moviesData: [Movie])
    func pushSearchedMoviesData(moviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    
    func catchResponse(withMessage: String)
}
