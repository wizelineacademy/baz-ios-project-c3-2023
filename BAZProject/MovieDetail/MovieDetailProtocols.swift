//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by hlechuga on 16/02/23.
//

import Foundation

//MARK: - View
protocol MovieDetailViewIntputProtocol: AnyObject {
    var presenter: MovieDetailViewOutputProtocol? { get }
    //MARK: - Functions
    func loadView(from model: [MovieDetailType])
}

//MARK: - Interactor
protocol MovieDetailInteractorInputProtocol {
    var presenter: MovieDetailInteractorOutputProtocol? { get }
    
    // MARK: Functions
    func fetchModel(with movie: Movie)
}

//MARK: - Presenter
protocol MovieDetailViewOutputProtocol {
    var view: MovieDetailViewIntputProtocol? { get }
    var interactor: MovieDetailInteractorInputProtocol? { get }
    var router : MovieDetailRouterProtocol? { get }
    
    // MARK: Functions
    func fetchModel(with movie: Movie)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func presentView(model: [MovieDetailType])
}

//MARK: - Router
protocol MovieDetailRouterProtocol {
    
}
