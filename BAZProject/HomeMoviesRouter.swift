//
//  HomeMoviesRouter.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import Foundation
import UIKit

class HomeMoviesRouter: HomeMoviesRouterProtocol {

    class func createHomeMoviesModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationMovies")
        if let view = navController.children.first as? HomeMoviesView {
            let presenter: HomeMoviesPresenterProtocol & HomeMoviesInteractorOutputProtocol = HomeMoviesPresenter()
            let interactor: HomeMoviesInteractorInputProtocol & HomeMoviesRemoteDataManagerOutputProtocol = HomeMoviesInteractor()
            let localDataManager: HomeMoviesLocalDataManagerInputProtocol = HomeMoviesLocalDataManager()
            let remoteDataManager: HomeMoviesRemoteDataManagerInputProtocol = HomeMoviesRemoteDataManager()
            let router: HomeMoviesRouterProtocol = HomeMoviesRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "HomeMoviesView", bundle: Bundle.main)
    }
    
}
