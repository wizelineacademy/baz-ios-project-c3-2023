//
//  ErrorPageRouter.swift
//  BAZProject
//
//  Created by 1058889 on 31/01/23.
//

import UIKit

class ErrorPageRouter: ErrorPageRouterProtocol {
    static func createModule(errorType: ErrorType) -> UIViewController {
        guard let view = ErrorPageViewController(
            nibName: ErrorPageViewController.nibName,
            bundle: nil) as? ErrorPageViewProtocol
        else {
            return UIViewController()
        }

        let interactor: ErrorPageInteractorInputProtocol = ErrorPageInteractor()
        let presenter: ErrorPagePresenterProtocols = ErrorPagePresenter()
        let router: ErrorPageRouterProtocol = ErrorPageRouter()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
    
    func closeThisInstance() {
        
    }
}
