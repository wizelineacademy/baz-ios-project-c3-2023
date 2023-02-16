//
//  InformationMoviesProtocols.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

protocol InformationMoviesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: InformationMoviesPresenterProtocol? { get set }
    
    func reloadCollectionViewData()
    func catchResponse(withMessage: String?)
}

protocol InformationMoviesRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createInformationMovieModule(informationMovieData: InformationMovie) -> UIViewController
    
    func goToInformationMovie(informationMovieData: InformationMovie, view: InformationMoviesViewProtocol)
}

protocol InformationMoviesPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: InformationMoviesViewProtocol? { get set }
    var interactor: InformationMoviesInteractorInputProtocol? { get set }
    var router: InformationMoviesRouterProtocol? { get set }
    var informationMovieData: InformationMovie? { get set }
    
    func loadingView()
    
    func getSimilarMoviesCount() -> Int
    func getSimilarMovie(indexPathRow: Int) -> Movie
    func getInformationMovie(idMovie: Int)
}

protocol InformationMoviesInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushSimilarMoviesData(similarMoviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    
    func catchResponse(withMessage: String)
}

protocol InformationMoviesInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: InformationMoviesInteractorOutputProtocol? { get set }
    var remoteDatamanager: InformationMoviesRemoteDataManagerInputProtocol? { get set }
    
    func getMovieSimilar(idMovie: Int)
    func getInformationMovie(idMovie: Int)
}

protocol InformationMoviesDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol InformationMoviesRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: InformationMoviesRemoteDataManagerOutputProtocol? { get set }
    
    func getMovieSimilar(idMovie: Int)
    func getInformationMovie(idMovie: Int)
}

protocol InformationMoviesRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushSimilarMoviesData(similarMoviesData: [Movie])
    func pushInformationMovieData(movieData: InformationMovie)
    func catchResponse(withMessage: String)
}
