//
//  MovieSearchProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 10/02/23.
//

import Foundation

protocol MSPresenterProtocol {
    var view: MSViewInputProtocol? { get }
    var interactor: MSInteractorInputProtocol { get }
    var router: MSRouterProtocol { get }
}

protocol MSViewOutputProtocol: MSPresenterProtocol {
    func didLoadView()
    func searchMovies(by text: String?)
    func didSelect(_ movie: Movie)
}

protocol MSViewInputProtocol: AnyObject {
    var output: MSViewOutputProtocol? { get set }
    
    func setupView(with data: MSEntity)
    func set(movies: [Movie])
    func clearCollection()
    func show(_ error: Error)
}

protocol MSInteractorInputProtocol {
    var output: MSInteractorOutputProtocol? { get set }
    
    func fetchViewData()
    func fetchMovies(by text: String?)
}

protocol MSInteractorOutputProtocol: AnyObject {
    func setView(with data: MSEntity)
    func didReceive(_ movies: [Movie])
    func didReceive(_ error: Error)
    
}

protocol MSRouterProtocol {
    func goNextViewController(with movie: Movie)
}
