//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 10/02/23.
//

import Foundation

protocol MDViewOutputProtocol {
    var view: MDViewInputProtocol? { get }
    var interactor: MDInteractorInputProtocol { get }
    
    func didLoadView()
}

protocol MDViewInputProtocol: AnyObject {
    var output: MDViewOutputProtocol? { get set }
    
    func setView(with movie: Movie)
}

protocol MDInteractorInputProtocol {
    var output: MDInteractorOutputProtocol? { get set }
    
    func fetchData()
}

protocol MDInteractorOutputProtocol: AnyObject {
    func present(_ movie: Movie)
}
