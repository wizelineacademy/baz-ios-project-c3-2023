//
//  MovieDetailProtocol.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

protocol MovieDetailRouterProtocol: AnyObject, RouterProtocols {
    //Presenter -> Router
}

protocol MovieDetailViewProtocol: AnyObject {
    // Presenter -> View
    var presenter : MovieDetailPresenterProtocol? {get set}
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MovieDetailViewProtocol? {get set}
    var interceptor : MovieDetailInterceptorInputProtocol? {get set}
}

protocol MovieDetailInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: MovieDetailInteractorOutputProtocol? {get set}
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

