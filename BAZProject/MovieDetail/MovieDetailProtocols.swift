//
//  MovieDetailProtocols.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 10/02/23.
//

import Foundation

protocol MDPresenterProtocol {
    var view: MDViewInputProtocol? { get }
    var interactor: MDInteractorInputProtocol { get }
    var router: MDRouterProtocol { get }
}

protocol MDViewOutputProtocol: MDPresenterProtocol {
    func didLoadView()
    func didSelect(_ movie: Movie)
}

protocol MDViewInputProtocol: AnyObject {
    var output: MDViewOutputProtocol? { get set }
    var tableViewDataSource: DetailDataSource? { get set }
    var tableViewDelegate: DetailTableViewDelegate? { get set }
    
    func setupTable(with cells: [any GenericTableViewCell.Type])
    func setRows(with rows: [any GenericTableViewRow])
    func setTitle(_ title: String)
    func show(_ error: Error)
}

protocol MDInteractorInputProtocol {
    var output: MDInteractorOutputProtocol? { get set }
    
    func fetchTitle()
    func fetchCellClasses()
    func fetchMovieDetail()
}

protocol MDInteractorOutputProtocol: AnyObject {
    func setTitleForView(_ title: String)
    func setupCells(_ cells: [any GenericTableViewCell.Type])
    func didFind(_ details: [GenericTableViewRow])
    func didFind(_ error: Error)
}

protocol MDRouterProtocol {
    var view: MDViewInputProtocol? { get }
    func goNextViewController(with movie: Movie)
}
