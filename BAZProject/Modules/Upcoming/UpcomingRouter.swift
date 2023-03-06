//
//  UpcomingRouter.swift
//  BAZProject
//
//  Created by 1029187 on 02/03/23.
//

import UIKit

class UpcomingRouter: UpcomingRouterProtocol {

    class func createUpcomingModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "UpcomingViewController") as! UpcomingViewController
        let presenter: UpcomingPresenterProtocol & UpcomingInteractorOutputProtocol = UpcomingPresenter()
        let interactor: UpcomingInteractorInputProtocol & UpcomingRemoteDataManagerOutputProtocol = UpcomingInteractor()
        let remoteDataManager: UpcomingRemoteDataManagerInputProtocol = UpcomingRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: UpcomingRouterProtocol = UpcomingRouter()
            
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

extension UpcomingRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
