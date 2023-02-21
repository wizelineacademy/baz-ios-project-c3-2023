//
//  ListMoviesProtocols.swift
//  BAZProject
//
//  Created by hlechuga on 20/02/23.
//

import Foundation

//MARK: - View
protocol ListMoviesViewInputProtocol:AnyObject {
    var presenter:ListMoviesViewOutputProtocol? { get }
    
    //MARK: - Functions
    func loadView(from model: [AllMovieTypes])
}

//MARK: - Interactor
protocol ListMoviesInteractorInputProtocol {
    var presenter:ListMoviesInteractorOutputProtocol? { get }
    
    //MARK: - Functions
    func fetchModel()
}

//MARK: - Presenter
protocol ListMoviesViewOutputProtocol {
    var view: ListMoviesViewInputProtocol? { get }
    var interactor: ListMoviesInteractorInputProtocol? { get }
    var router: ListMoviesRouterProtocol? { get }
    
    //MARK: - Functions
    func fetchModel()
    func goToNextViewController(with model: Movie)
    func goToSearchViewController()
}

protocol ListMoviesInteractorOutputProtocol: AnyObject{
    func presentView(model: [AllMovieTypes])
}

//MARK: - Router
protocol ListMoviesRouterProtocol {
    
    //MARK: - Functions
    func goToNextViewController(with model: Movie)
    func goToSearchViewController()
}
