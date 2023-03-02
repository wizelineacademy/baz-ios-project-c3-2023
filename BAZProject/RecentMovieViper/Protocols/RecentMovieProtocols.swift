//
//  RecentMovieProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import UIKit

protocol RecentMovieViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: RecentMoviePresenterProtocol? { get set }
    func reloadView()
}

protocol RecentMovieRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createRecentMovieModule(idMovies: [Int]) -> UIViewController
    func goToDetails(from view: RecentMovieViewProtocol, idMovie: Int)
}

protocol RecentMoviePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: RecentMovieViewProtocol? { get set }
    var interactor: RecentMovieInteractorInputProtocol? { get set }
    var router: RecentMovieRouterProtocol? { get set }
    var idMovies: [Int]? { get set }
    
    func viewDidLoad()
    func getRecentCount() -> Int
    func getCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func didSelectTable(index: Int)
}

protocol RecentMovieInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func pushRecentMovie(recentMovie: RecentMovie)
}

protocol RecentMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: RecentMovieInteractorOutputProtocol? { get set }
    var remoteDatamanager: RecentMovieRemoteDataManagerInputProtocol? { get set }
    
    func getMovies(idMovies: [Int]?)
}

protocol RecentMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: RecentMovieRemoteDataManagerOutputProtocol? { get set }
    
    func getMovie(idMovie: Int)
}

protocol RecentMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushRecentMovie(recentMovie: RecentMovie)
}


