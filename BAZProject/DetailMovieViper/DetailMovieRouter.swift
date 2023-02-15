//
//  DetailMovieRouter.swift
//  BAZProject
//
//  Created by 1050210 on 11/02/23.
//  
//

import Foundation
import UIKit

class DetailMovieRouter: DetailMovieRouterProtocol {

    class func createDetailMovieModule(idMovie: Int) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailMovieView")
        if let view = viewController as? DetailMovieView {
            let presenter: DetailMoviePresenterProtocol & DetailMovieInteractorOutputProtocol = DetailMoviePresenter()
            let interactor: DetailMovieInteractorInputProtocol & DetailMovieRemoteDataManagerOutputProtocol = DetailMovieInteractor()
            let localDataManager: DetailMovieLocalDataManagerInputProtocol = DetailMovieLocalDataManager()
            let remoteDataManager: DetailMovieRemoteDataManagerInputProtocol = DetailMovieRemoteDataManager()
            let router: DetailMovieRouterProtocol = DetailMovieRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.idMovie = idMovie
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "DetailMovieView", bundle: Bundle.main)
    }
    
}
