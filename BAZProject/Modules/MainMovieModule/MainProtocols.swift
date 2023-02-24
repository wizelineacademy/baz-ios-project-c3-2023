//
//  MainProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    // Presenter -> View
    var presenter: MainPresenterProtocol? { get set }
    var tableView: UITableView! { get set }
    
    func reloadData()
}

protocol MainPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    
    func goToSearchMovieView()
    func goToMovieDetail(data: Movie)
    func viewDidLoad(tableView: UITableView)
    func getTableViewDataSource() -> UITableViewDataSource
    func getTableViewDelegate() -> UITableViewDelegate
}

protocol MainInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MainInteractorOutputProtocol? { get set }
    var movieApiData: DataHelper { get set }
    var countMovieWatched: Int { get set }
    
    func getMoviesData(from api: URLApi, dispatchGroup: DispatchGroup?, completionHandler: @escaping () -> Void)
}

extension MainInteractorInputProtocol {
    func getMoviesData(from api: URLApi, dispatchGroup: DispatchGroup? = nil, completionHandler: @escaping () -> Void) {
        getMoviesData(from: api, dispatchGroup: dispatchGroup, completionHandler: completionHandler)
    }
}

protocol MainInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}

