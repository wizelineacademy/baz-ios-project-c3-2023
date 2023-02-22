//  HomeRouter.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class HomeRouter {
    // MARK: - Protocol properties
    weak var view: HomeViewProtocol?

    // MARK: Static methods
    static func createModule() -> UIViewController {
        let view: HomeViewProtocol = HomeViewController(nibName: HomeViewController.identifier, bundle: nil)
        let service: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let dataManager: HomeDataManagerInputProtocol = HomeDataManager(providerNetworking: service)
        let interactor: HomeInteractorInputProtocol & HomeDataManagerOutputProtocol = HomeInteractor()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        router.view = view
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

extension HomeRouter: HomeRouterProtocol {
    func showViewError(_ errorType: ErrorType) {
        guard let view = self.view as? UIViewController else { return }
        view.guaranteeMainThread {
            let errorPageVC: UIViewController = ErrorPageRouter.createModule(errorType: errorType)
            view.navigationController?.pushViewController(errorPageVC, animated: false)
        }
    }
}
