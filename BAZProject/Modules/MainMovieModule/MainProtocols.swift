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
    var segmentControl: UISegmentedControl! { get set }
    
    func reloadData()
}

protocol MainPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MainViewProtocol? { get set }
    var interactor: MainInteractorInputProtocol? { get set }
    
    func goToSearchMovieView()
    func goToMovieDetail(data: Result)
    func viewDidLoad()
    func getMoviesData(from api: URLApi)
}

protocol MainInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MainInteractorOutputProtocol? { get set }
    var movieApiData: DataHelper { get set }
    
    func getMoviesData(from api: URLApi)
}

protocol MainInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}

