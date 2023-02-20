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
    func saveMovie()
    func goToMovieDetail(data: Result)
}

protocol MovieDetailInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var data: Result? { get set }
    var movieApiData: DataHelper { get set }
    
    func getMoviesData(from api: URLApi, structure: Codable.Type)
    func getMoviesDataWithId(from api: URLApi, id idMovie: Int, structure: Codable.Type)
    func saveMovie()
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}

