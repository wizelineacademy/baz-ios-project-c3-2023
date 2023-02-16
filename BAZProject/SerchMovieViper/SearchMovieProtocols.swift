//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import Foundation
import UIKit

protocol SearchMovieViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchMoviePresenterProtocol? { get set }
    func reloadView()
}

protocol SearchMovieRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createSearchMovieModule() -> UIViewController
    func goToDetails(from view: SearchMovieViewProtocol, idMovie: Int)
}

protocol SearchMoviePresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchMovieViewProtocol? { get set }
    var interactor: SearchMovieInteractorInputProtocol? { get set }
    var router: SearchMovieRouterProtocol? { get set }

    func setSearching(isSearching: Bool, searchTerm: String)
    func getTableViewCount() -> Int
    func getTableSize() -> CGFloat
    func getText(index: Int) -> String?
    func tableSelected(tableView: UITableView, indexPath: IndexPath)
    func cleanView()
    func getSearchMovie(index: Int) -> SearchMovie
    func getSearchedImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func getCell(tableView: UITableView, indexPath: Int) -> UITableViewCell
}

protocol SearchMovieInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
    func pushSearchedMovies(searchedMovies: [SearchMovie])
    func pushKeyword(keyword: [Keyword])
}

protocol SearchMovieInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchMovieInteractorOutputProtocol? { get set }
    var localDatamanager: SearchMovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchMovieRemoteDataManagerInputProtocol? { get set }
    
    func getSearched(searchTerm: String)
    func getKeyword(keyword: String)
}

protocol SearchMovieDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol SearchMovieRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: SearchMovieRemoteDataManagerOutputProtocol? { get set }
    
    func getSearched(searchTerm: String)
    func getKeyword(keyword: String)
}

protocol SearchMovieRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
    func pushSearchedMovies(searchedMovies: [SearchMovie])
    func pushKeyword(keyword: [Keyword])
}

protocol SearchMovieLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
