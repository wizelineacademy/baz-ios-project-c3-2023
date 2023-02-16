//
//  SearchMovieRouter.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import Foundation
import UIKit

class SearchMovieRouter: SearchMovieRouterProtocol {
  
    class func createSearchMovieModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SearchMovieView")
        if let view = viewController as? SearchMovieView {
            let presenter: SearchMoviePresenterProtocol & SearchMovieInteractorOutputProtocol = SearchMoviePresenter()
            let interactor: SearchMovieInteractorInputProtocol & SearchMovieRemoteDataManagerOutputProtocol = SearchMovieInteractor()
            let localDataManager: SearchMovieLocalDataManagerInputProtocol = SearchMovieLocalDataManager()
            let remoteDataManager: SearchMovieRemoteDataManagerInputProtocol = SearchMovieRemoteDataManager()
            let router: SearchMovieRouterProtocol = SearchMovieRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "SearchMovieView", bundle: Bundle.main)
    }
    
    func goToDetails(from view: SearchMovieViewProtocol, idMovie: Int) {
        let newDetailView = DetailMovieRouter.createDetailMovieModule(idMovie: idMovie)
        
        if let newView = view as? UIViewController{
            newView.present(newDetailView, animated: true)
        }
    }
    

}
