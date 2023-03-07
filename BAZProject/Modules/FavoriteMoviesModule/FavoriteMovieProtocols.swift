//
//  FavoriteMovieViewProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

protocol FavoriteMovieViewProtocol: AnyObject {
    var presenter: FavoriteMoviePresenterProtocol? { get set }
    
    func reloadData()
}

protocol FavoriteMoviePresenterProtocol: AnyObject {
    var view: FavoriteMovieViewProtocol? { get set }
    var interactor: FavoriteMovieInteractorInputProtocol? { get set }
    
    func viewDidLoad(tableView: UITableView)
    func getFavoriteMovies()
    func getTableViewDataSource() -> UITableViewDataSource
    func getTableViewDelegate() -> UITableViewDelegate
}

protocol FavoriteMovieInteractorInputProtocol: AnyObject {
    var presenter: FavoriteMovieInteractorOutputProtocol? { get set }
    var getDataMovies: [Movie]? { get set }

    func getFavoriteMovies(from api: URLApi)
    func setIdMovies()
}

protocol FavoriteMovieInteractorOutputProtocol: AnyObject {
    
}
