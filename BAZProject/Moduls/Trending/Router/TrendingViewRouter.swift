//
//  TrendingViewRouter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

class TrendingViewRouter: TrendingRouterProtocol {
    static func createModule() -> UIViewController {
        guard let view = TrendingViewController(
            nibName: TrendingViewController.nibName,
            bundle: nil) as? TrendingViewProtocol
        else {
            return UIViewController()
        }
        let interactor: TrendingInteractorProtocol = TrendingInteractor()
        let presenter: presenterProtocols = TrendingViewPresenter()

        let router: TrendingRouterProtocol = TrendingViewRouter()

        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view.presenter = presenter

        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
}