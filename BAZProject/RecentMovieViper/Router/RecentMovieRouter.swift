//
//  RecentMovieRouter.swift
//  BAZProject
//
//  Created by 1050210 on 28/02/23.
//  
//

import UIKit

class RecentMovieRouter: RecentMovieRouterProtocol {
  
    class func createRecentMovieModule(idMovies: [Int]) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "RecentMovieView")
        if let view = viewController as? RecentMovieView {
            let presenter: RecentMoviePresenterProtocol & RecentMovieInteractorOutputProtocol = RecentMoviePresenter()
            let interactor: RecentMovieInteractorInputProtocol & RecentMovieRemoteDataManagerOutputProtocol = RecentMovieInteractor()
            let remoteDataManager: RecentMovieRemoteDataManagerInputProtocol = RecentMovieRemoteDataManager()
            let router: RecentMovieRouterProtocol = RecentMovieRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.idMovies = idMovies
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "RecentMovieView", bundle: Bundle.main)
    }
    
    func goToDetails(from view: RecentMovieViewProtocol, idMovie: Int) {
        let newDetailView = DetailMovieRouter.createDetailMovieModule(idMovie: idMovie)
        
        if let newView = view as? UIViewController {
            newView.present(newDetailView, animated: true)
        }
    }
}
