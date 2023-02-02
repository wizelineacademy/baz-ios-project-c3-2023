//
//  MovieDetailProtocol.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

protocol MovieDetailRouterProtocol: AnyObject {
    //Presenter -> Router
    static func createLoginModule() -> UIViewController
}

protocol MovieDetailViewProtocol: AnyObject {
    // Presenter -> View
    var presenter : MovieDetailPresenterProtocol? {get set}
}

protocol MovieDetailPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MovieDetailViewProtocol? {get set}
    var router: MovieDetailRouterProtocol? {get set}
    var interceptor : MovieDetailInterceptorInputProtocol? {get set}
}

protocol MovieDetailInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: MovieDetailInteractorOutputProtocol? {get set}
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

