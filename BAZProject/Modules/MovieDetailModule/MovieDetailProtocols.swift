//
//  MovieDetailProtocol.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

protocol MovieDetailViewProtocol:AnyObject {
    // Presenter -> View
    var presenter:MovieDetailPresenterProtocol? {get set}
    var poster: UIImageView! {get set}
    var titleMovie: UILabel!  {get set}
}

protocol MovieDetailPresenterProtocol:AnyObject {
    // View -> Presenter
    var view: MovieDetailViewProtocol? {get set}
    var interceptor: MovieDetailInterceptorInputProtocol? {get set}
    
    func viewDidLoad()
}

protocol MovieDetailInterceptorInputProtocol:AnyObject {
    // Presenter -> Interceptor
    var presenter:MovieDetailInteractorOutputProtocol? {get set}
    var data:Result? {get set}
    var movieApi:MovieAPI {get set}
}

protocol MovieDetailInteractorOutputProtocol:AnyObject {
    // INTERACTOR -> PRESENTER
}

