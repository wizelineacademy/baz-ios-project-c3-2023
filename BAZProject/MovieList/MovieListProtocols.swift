//
//  MovieListProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 10/02/23.
//

import UIKit

protocol MLPresenterProtocol {
    var view: MLViewInputProtocol? { get }
    var interactor: MLInteractorInputProtocol { get }
    var router: MLRouterProtocol { get }
}

protocol MLViewOutputProtocol: AnyObject {
    func didLoadView()
    func didSelect(_ movie: Movie)
}

protocol MLViewInputProtocol: UIViewController {
    var output: MLViewOutputProtocol? { get set }
    
    func setTitle(_ title: String)
    func setMovies(_ movies: [Movie])
    func show(_ error: Error)
}

protocol MLInteractorInputProtocol {
    var output: MLInteractorOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol MLInteractorOutputProtocol: AnyObject {
    func set(title: String)
    func didFind(movies: [Movie])
    func didFind(error: Error)
}

protocol MLRouterProtocol {
    var view: MLViewInputProtocol? { get }
    
    func goNextViewController(with movie: Movie)
}
