//  ReviewRouter.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ReviewRouter {
    // MARK: - Protocol properties
    weak var view: ReviewViewProtocol?

    // MARK: Static methods
    static func createModule(idMovie: String) -> UIViewController {
        let view: ReviewViewProtocol = ReviewViewController(nibName: ReviewViewController.identifier, bundle: nil)
        let service: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let dataManager: ReviewDataManagerInputProtocol = ReviewDataManager(providerNetworking: service)
        let interactor: ReviewInteractorInputProtocol & ReviewDataManagerOutputProtocol = ReviewInteractor()
        let presenter: ReviewPresenterProtocol & ReviewInteractorOutputProtocol = ReviewPresenter()
        let router: ReviewRouterProtocol = ReviewRouter()

        view.presenter = presenter
        view.idMovie = idMovie
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

extension ReviewRouter: ReviewRouterProtocol {
    func showViewError(_ errorType: ErrorType) {
        guard let view = self.view as? UIViewController else { return }
        view.guaranteeMainThread {
            let errorPageVC: UIViewController = ErrorPageRouter.createModule(errorType: errorType)
            view.navigationController?.pushViewController(errorPageVC, animated: true)
        }
    }
}
