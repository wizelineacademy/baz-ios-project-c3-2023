//
//  HomeMoviesRouter.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class HomeMoviesRouter: HomeMoviesRouterProtocol {

    // MARK: - Create Module HomeMovies
    class func createHomeMoviesModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "HomeMovies")
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

    // MARK: - Properties
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "HomeMovies", bundle: nil)
    }

    /**
     Function that calls the Information movie view to show next.
     */
    func goToInformationMovie(informationMovieData: InformationMovie, view: HomeMoviesViewProtocol) {
        if let newView = view as? UIViewController {
            DispatchQueue.main.async {
                let movieDatail = InformationMoviesRouter.createInformationMovieModule(informationMovieData: informationMovieData)
                newView.navigationController?.pushViewController(movieDatail, animated: true)
            }
        }
    }
}
