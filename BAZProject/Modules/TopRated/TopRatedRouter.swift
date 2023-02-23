//
//  TopRatedRouter.swift
//  BAZProject
//
//  Created by 1029187 on 02/02/23.
//  
//

import UIKit

class TopRatedRouter: TopRatedRouterProtocol {

    class func createTopRatedModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "TopRatedView") as! TopRatedView
        let presenter: TopRatedPresenterProtocol & TopRatedInteractorOutputProtocol = TopRatedPresenter()
        let interactor: TopRatedInteractorInputProtocol & TopRatedRemoteDataManagerOutputProtocol = TopRatedInteractor()
        let remoteDataManager: TopRatedRemoteDataManagerInputProtocol = TopRatedRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: TopRatedRouterProtocol = TopRatedRouter()
            
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension TopRatedRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
