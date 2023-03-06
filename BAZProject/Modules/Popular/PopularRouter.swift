//
//  PopularRouter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class PopularRouter: PopularRouterProtocol {

    class func createPopularModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "PopularViewController") as! PopularViewController
        let presenter: PopularPresenterProtocol & PopularInteractorOutputProtocol = PopularPresenter()
        let interactor: PopularInteractorInputProtocol & PopularRemoteDataManagerOutputProtocol = PopularInteractor()
        let remoteDataManager: PopularRemoteDataManagerInputProtocol = PopularRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: PopularRouterProtocol = PopularRouter()
            
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

extension PopularRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
