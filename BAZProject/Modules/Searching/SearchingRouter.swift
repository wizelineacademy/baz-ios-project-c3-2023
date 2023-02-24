//
//  SearchingRouter.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

class SearchingRouter: SearchingRouterProtocol {

    class func createSearchingModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "SearchingViewController") as! SearchingViewController
        let presenter: SearchingPresenterProtocol & SearchingInteractorOutputProtocol = SearchingPresenter()
        let interactor: SearchingInteractorInputProtocol & SearchingRemoteDataManagerOutputProtocol = SearchingInteractor()
        let remoteDataManager: SearchingRemoteDataManagerInputProtocol = SearchingRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: SearchingRouterProtocol = SearchingRouter()
            
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

extension SearchingRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
