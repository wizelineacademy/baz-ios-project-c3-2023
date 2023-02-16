//
//  SearchingProtocols.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

protocol SearchingViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: SearchingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol SearchingRouterProtocol: AnyObject {
    // PRESENTER -> ROUTER
    static func createSearchingModule() -> UIViewController
}

protocol SearchingPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: SearchingViewProtocol? { get set }
    var interactor: SearchingInteractorInputProtocol? { get set }
    var router: SearchingRouterProtocol? { get set }
    
    func notifyViewLoaded()
}

protocol SearchingInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}

protocol SearchingInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: SearchingInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol? { get set }
}

protocol SearchingRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: TopRatedRemoteDataManagerOutputProtocol? { get set }
}

protocol SearchingRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}
