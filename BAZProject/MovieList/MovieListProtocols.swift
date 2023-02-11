//
//  MovieListProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 10/02/23.
//

import UIKit

protocol MLViewOutputProtocol: AnyObject {
    var view: MLViewInputProtocol? { get }
    var interactor: MLInteractorInputProtocol { get }
    var router: MLRouterProtocol { get }
    
    func didLoadView()
    func didSelect(_ movie: Movie)
}

protocol MLViewInputProtocol: UIViewController {
    var presenter: MLViewOutputProtocol? { get set }
    
    func setTitle(_ title: String)
    func setMovies(_ movies: [Movie])
    func show(_ error: Error)
}

protocol MLInteractorInputProtocol {
    var presenter: MLInteractorOutputProtocol? { get set }
    
    func fetchData()
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
