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
    var poster: UIImageView! { get set }
    
    func reloadData()
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInterceptorInputProtocol? { get set }
    
    func viewDidLoad(textOverview: inout UILabel, poster: inout UIImageView)
    func getMoviesData(from api: URLApi)
    func getTableViewDataSource() -> UITableViewDataSource
    func getTableViewDelegate() -> UITableViewDelegate
}

protocol MovieDetailInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var data: Result? { get set }
    var movieApiData: DataHelper { get set }
    
    func getMoviesData(from api: URLApi)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}

