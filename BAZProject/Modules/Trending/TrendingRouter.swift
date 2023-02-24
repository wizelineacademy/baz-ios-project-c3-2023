//
//  TrendingRouter.swift
//  BAZProject
//
//  Created by 1029187 on 27/01/23.
//

import UIKit

class TrendingRouter: TrendingRouterProtocol {

    class func createTrendingModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "TrendingView") as! TrendingView
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()
        let interactor: TrendingInteractorInputProtocol & TrendingRemoteDataManagerOutputProtocol = TrendingInteractor()
        let remoteDataManager: TrendingRemoteDataManagerInputProtocol = TrendingRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: TrendingRouterProtocol = TrendingRouter()
        
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

extension TrendingRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
