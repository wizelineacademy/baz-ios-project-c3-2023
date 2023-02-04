//
//  MainProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

protocol MainRouterProtocol: AnyObject {
    // PRESENTER -> Router
    static func createModule() -> UIViewController
    func presentView(from view: UIViewController)
}

protocol MainViewProtocol: AnyObject {
    // Presenter -> View
    var presenter : MainPresenterProtocol? {get set}
}


protocol MainPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MainViewProtocol? {get set}
    var interactor : MainInteractorInputProtocol? {get set}
    var router : MainRouterProtocol? {get set}
    func goTo()
}

protocol MainInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter : MainInteractorOutputProtocol? {get set}
}

protocol MainInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
