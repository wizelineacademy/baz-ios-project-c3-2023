//
//  MainProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    // Presenter -> View
    var presenter : MainPresenterProtocol? {get set}
    var tableView:UITableView! {get set}
}


protocol MainPresenterProtocol: AnyObject {
    // View -> Presenter
    var view: MainViewProtocol? {get set}
    var interactor : MainInteractorInputProtocol? {get set}
    func goToSearchMovieView()
    func viewDidLoad()
}

protocol MainInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter : MainInteractorOutputProtocol? {get set}
}

protocol MainInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}
