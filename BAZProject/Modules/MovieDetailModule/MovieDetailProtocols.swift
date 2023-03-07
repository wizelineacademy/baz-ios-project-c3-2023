//
//  MovieDetailProtocol.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

protocol MovieDetailViewProtocol: AnyObject {
    // Presenter -> View
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func reloadData()
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInterceptorInputProtocol? { get set }
    var isFavorite: Bool { get set }
    
    func viewDidLoad(poster: inout UIImageView, tableView: UITableView)
    func getTableViewDataSource() -> UITableViewDataSource
    func getTableViewDelegate() -> UITableViewDelegate
    func saveFavoriteMovie()
    func deleteToFavoriteMovie()
    func goToMovieDetail(data: Movie)
}

protocol MovieDetailInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var data: Movie? { get set }
    var movieApiData: DataHelper { get set }
    var saveData: SaveMovies { get }
    
    func getMoviesDataWithId(from api: URLApi, id idMovie: Int, structure: Codable.Type)
    func saveFavoriteMovie()
    func deleteToFavoriteMovie()
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}

