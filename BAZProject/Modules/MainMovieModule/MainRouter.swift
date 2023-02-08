//
//  MainRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

class MainRouter: RouterProtocols{
    typealias Router = MainRouter
    
    static func createLoginModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MainStoryboard")
        if let view = navController as? MainView{
            let presenter : MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
            let interactor : MainInteractorInputProtocol = MainInteractor()
            
            view.presenter = presenter
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
