//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

protocol SearchMovieViewProtocol: AnyObject {
//    Presenter -> View
    var presenter:SearchMoviePresenterProtocol? {get set}
    var tableView:UITableView! {get set}
    
    func reloadData()
}

protocol SearchMoviePresenterProtocol: AnyObject {
    //    View -> Presenter
    var view:SearchMovieViewProtocol? {get set}
    var interceptor:SearchMovieInterceptorInputProtocol? {get set}
    
    func viewDidLoad()
    func getKeywordSearch(keyword:String)
}

protocol SearchMovieInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter:SearchMovieInterceptorOutputProtocol? {get set}
    var movieApi: MovieAPI {get set}
    
    func getKeywordSearch(keyword:String)
}

protocol SearchMovieInterceptorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}
