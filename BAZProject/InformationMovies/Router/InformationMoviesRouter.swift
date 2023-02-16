//
//  InformationMoviesRouter.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

class InformationMoviesRouter: InformationMoviesRouterProtocol {
    
    // MARK: - Create Module InformationMoviesModule
    class func createInformationMovieModule(informationMovieData: InformationMovie) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "InformationMoviesView")
        if let view = viewController as? InformationMoviesView {
            let presenter: InformationMoviesPresenterProtocol & InformationMoviesInteractorOutputProtocol = InformationMoviesPresenter()
            let interactor: InformationMoviesInteractorInputProtocol & InformationMoviesRemoteDataManagerOutputProtocol = InformationMoviesInteractor()
            let remoteDataManager: InformationMoviesRemoteDataManagerInputProtocol = InformationMoviesRemoteDataManager()
            let router: InformationMoviesRouterProtocol = InformationMoviesRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.informationMovieData = informationMovieData
            interactor.presenter = presenter
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    // MARK: - Properties
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "InformationMoviesView", bundle: nil)
    }
    
    /**
     Function that calls the Information Movies view to show next.
     */
    func goToInformationMovie(informationMovieData: InformationMovie, view: InformationMoviesViewProtocol) {
        if let newView = view as? UIViewController {
            DispatchQueue.main.async {
                let movieDatail = InformationMoviesRouter.createInformationMovieModule(informationMovieData: informationMovieData)
                newView.navigationController?.pushViewController(movieDatail, animated: true)
            }
        }
    }
}
