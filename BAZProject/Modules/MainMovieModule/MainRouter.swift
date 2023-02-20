//
//  MainRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 01/02/23.
//

import UIKit

final class MainRouter: RouterProtocols{
    typealias Router = MainRouter
    
    static func createModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MainStoryboard")
        if let view = navController.children.first as? MainView {
            let presenter : MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
            let interactor : MainInteractorInputProtocol = MainInteractor()
            
            view.presenter = presenter
            interactor.presenter = presenter
            presenter.interactor = interactor
            presenter.view = view
            
            let navigationController = UINavigationController(rootViewController: view)
            return navigationController
        }
        return UIViewController()
    }
    
    
    static private var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
