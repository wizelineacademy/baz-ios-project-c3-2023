//
//  TrendingViewRouter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

final class TrendingRouter: TrendingRouterProtocol {
    weak var view: TrendingViewProtocol?
    private var alert: UIAlertController?

    static func createModule() -> UIViewController {
        let view: TrendingViewProtocol = TrendingViewController(nibName: TrendingViewController.identifier, bundle: nil)
        let service: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let dataManager: TrendingDataManagerInputProtocol = TrendingDataManager(providerNetworking: service)
        let interactor: TrendingInteractorInputProtocol & TrendingDataManagerOutputProtocol = TrendingInteractor()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()

        let router: TrendingRouterProtocol = TrendingRouter()
        router.view = view
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

    func showViewError(_ errorType: ErrorType) {
        guard let view = self.view as? UIViewController else { return }
        view.guaranteeMainThread {
            let errorPageVC: UIViewController = ErrorPageRouter.createModule(errorType: errorType)
            view.navigationController?.pushViewController(errorPageVC, animated: false)
        }
    }

    func showDetail(of detailType: DetailType) {
        guard let view = self.view as? UIViewController else { return }
        view.guaranteeMainThread {
            let detailView: UIViewController = DetailRouter.createModule(detailType: detailType)
            view.navigationController?.pushViewController(detailView, animated: false)
        }
    }

    func showAlertLoading(with alertType: ErrorType) {
        guard let view = self.view as? UIViewController else { return }
        alert = view.getAlertLoading(with: alertType)
        view.guaranteeMainThread {
            view.navigationController?.present(self.alert ?? UIAlertController(), animated: true)
        }
    }

    func hideAlertLoading() {
        guard let view = self.view as? UIViewController else { return }
        view.guaranteeMainThread {
            self.alert?.dismiss(animated: true) {
                view.guaranteeMainThread {
                    view.navigationController?.navigationItem.searchController?.searchBar.becomeFirstResponder()
                }
            }
        }
    }
}
