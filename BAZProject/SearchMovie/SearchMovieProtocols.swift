//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created by hlechuga on 20/02/23.
//

import Foundation

//MARK: - View
protocol SearchViewInputProtocol: AnyObject {
    var presenter:SearchViewOutputProtocol? { get }
    
    // MARK: Functions
    func loadView(from model: [Movie])
}

//MARK: - Interactor
protocol SearchInteractorInputProtocol {
    var presenter:SearchInteractorOutputProtocol? { get }
    
    //MARK: - Functions
    func fetchModel(with query: String)
}

//MARK: - Presenter
protocol SearchViewOutputProtocol {
    var view: SearchViewInputProtocol? { get }
    var interactor: SearchInteractorInputProtocol? { get}
    var router: SearchRouterProtocol? { get }
    
    //MARK: - Functions
    func fetchModel(with query: String)
    func goToMovieDetail(with movie: Movie)
}
protocol SearchInteractorOutputProtocol: AnyObject {
    func presentView(with model: [Movie])
}

//MARK: - Router
protocol SearchRouterProtocol {}
