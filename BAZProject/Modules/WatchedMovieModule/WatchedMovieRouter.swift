//
//  WatchedMovieRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

class WatchedMovieRouter: RouterProtocols {
    typealias Router = WatchedMovieRouter
    
    static func createModule() -> UIViewController {
        let viewController = WatchedMovieStoryboard.instantiateViewController(withIdentifier: "WatchedMovieViewController")
        if let viewController = viewController as? WatchedMovieViewController {
            let interactor = WatchedMovieInteractor()
            let presenter = WatchedMoviePresenter()
            
            viewController.presenter = presenter
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.view = viewController
            
            let navigationBar = UINavigationController(rootViewController: viewController)
            
            return navigationBar
        }
        return UIViewController()
    }
    
    static var WatchedMovieStoryboard: UIStoryboard {
        return UIStoryboard(name: "WatchedMovieViewController", bundle: Bundle.main)
    }
    
}
