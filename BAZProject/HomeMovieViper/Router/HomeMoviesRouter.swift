//
//  HomeMoviesRouter.swift
//  BAZProject
//
//  Created by 1050210 on 29/01/23.
//  
//

import UIKit

class HomeMoviesRouter: HomeMoviesRouterProtocol {
   
    class func createHomeMoviesModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationMovies")
        if let view = navController.children.first as? HomeMoviesView {
            let presenter: HomeMoviesPresenterProtocol & HomeMoviesInteractorOutputProtocol = HomeMoviesPresenter()
            let interactor: HomeMoviesInteractorInputProtocol & HomeMoviesRemoteDataManagerOutputProtocol = HomeMoviesInteractor()
            let remoteDataManager: HomeMoviesRemoteDataManagerInputProtocol = HomeMoviesRemoteDataManager()
            let router: HomeMoviesRouterProtocol = HomeMoviesRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "HomeMoviesView", bundle: Bundle.main)
    }
    
    func goToDetails(from view: HomeMoviesViewProtocol, idMovie: Int) {
        let newDetailView = DetailMovieRouter.createDetailMovieModule(idMovie: idMovie)
        
        if let newView = view as? UIViewController{
            newView.present(newDetailView, animated: true)
        }
    }
    
    func goToSearch(from view: HomeMoviesViewProtocol) {
        let newSearchView = SearchMovieRouter.createSearchMovieModule()
        
        if let newView = view as? UIViewController{
            newView.navigationController?.pushViewController(newSearchView, animated: true)
        }
    }
    
   
}
