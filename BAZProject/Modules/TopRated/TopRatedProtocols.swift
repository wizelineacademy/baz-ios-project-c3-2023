//
//  TopRatedProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import UIKit

protocol TopRatedViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: TopRatedPresenterProtocol? { get set }
}

protocol TopRatedRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createTopRatedModule() -> UIViewController
}

protocol TopRatedPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: TopRatedViewProtocol? { get set }
    var interactor: TopRatedInteractorInputProtocol? { get set }
    var router: TopRatedRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol TopRatedInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}

protocol TopRatedInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: TopRatedInteractorOutputProtocol? { get set }
    var localDatamanager: TopRatedLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol? { get set }
}

protocol TopRatedDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> DATAMANAGER
}

protocol TopRatedRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: TopRatedRemoteDataManagerOutputProtocol? { get set }
}

protocol TopRatedRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol TopRatedLocalDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> LOCALDATAMANAGER
}
