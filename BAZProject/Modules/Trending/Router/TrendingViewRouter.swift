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

        let dataManager: TrendingDataManagerInputProtocol = TrendingDataManager(providerNetworking: NetworkingProviderService.shared)
        let interactor: TrendingInteractorInputProtocol & TrendingDataManagerOutputProtocol = TrendingInteractor()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()

        let router: TrendingRouterProtocol = TrendingViewRouter()

        view.presenter = presenter
        interactor.dataManager = dataManager
        interactor.presenter = presenter
        dataManager.interactor = interactor
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
}
