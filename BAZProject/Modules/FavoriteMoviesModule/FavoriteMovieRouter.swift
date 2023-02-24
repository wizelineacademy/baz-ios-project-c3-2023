//
//  FavoriteMovieRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 18/02/23.
//

import UIKit

final class FavoriteMovieRouter: RouterProtocols {
    typealias Router = FavoriteMovieRouter
    
    static func createModule() -> UIViewController {
        let viewController = FavoriteStoryboard.instantiateViewController(withIdentifier: "FavoriteMovie")
        if let view = viewController as? FavoriteMovieView {
            let presenter = FavoriteMoviePresenter()
            let interactor = FavoriteMovieInteractor()
            
            view.presenter = presenter
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            
            let navVar = UINavigationController(rootViewController: view)
            
            return navVar
        }
        return UIViewController()
    }
    
    static var FavoriteStoryboard: UIStoryboard {
        return UIStoryboard(name: "FavoriteMovie", bundle: Bundle.main)
    }
    
}
