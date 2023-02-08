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
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "TopRatedView")
        let view = navController.children.first as! TopRatedView
        let presenter: TopRatedPresenterProtocol & TopRatedInteractorOutputProtocol = TopRatedPresenter()
        let interactor: TopRatedInteractorInputProtocol & TopRatedRemoteDataManagerOutputProtocol = TopRatedInteractor()
        let localDataManager: TopRatedLocalDataManagerInputProtocol = TopRatedLocalDataManager()
        let remoteDataManager: TopRatedRemoteDataManagerInputProtocol = TopRatedRemoteDataManager()
        let router: TopRatedRouterProtocol = TopRatedRouter()
            
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
            
        return navController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "TopRatedView", bundle: Bundle.main)
    }
    
}
