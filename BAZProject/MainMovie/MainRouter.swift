//
//  MainRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainRouter: MainRouterProtocol{
    static func createLoginModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MainStoryboard")
        if let view = navController as? MainView{
            let presenter : MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
            let interactor : MainInteractorInputProtocol = MainInteractor()
            let router : MainRouterProtocol  = MainRouter()
            
            view.presenter = presenter
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.router = router
            presenter.view = view
            
            return navController
        }
        return UIViewController()
    }
    
    func presentNewViewSignUp(from view: MainViewProtocol) {
        
    }
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
