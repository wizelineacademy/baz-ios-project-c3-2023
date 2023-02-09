//
//  ErrorPageRouter.swift
//  BAZProject
//
//  Created by 1058889 on 31/01/23.
//

import UIKit

class ErrorPageRouter: ErrorPageRouterProtocol {
    var view: ErrorPageViewProtocol?
    
    static func createModule(errorType: ErrorType) -> UIViewController {
        let view: ErrorPageViewProtocol = ErrorPageViewController(
            nibName: ErrorPageViewController.identifier,
            bundle: nil)

        let interactor: ErrorPageInteractorInputProtocol = ErrorPageInteractor()
        let presenter: ErrorPagePresenterProtocols = ErrorPagePresenter()
        let router: ErrorPageRouterProtocol = ErrorPageRouter()

        view.presenter = presenter
        view.errorType = errorType
        router.view = view
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
    
    func closeThisInstance() {
        guard let view = view as? UIViewController else { return }
        view.navigationController?.popViewController(animated: true)
        view.dismiss(animated: true)
    }
}
