//
//  TrendingViewRouter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

class TrendingViewRouter: TrendingRouterProtocol {
    weak var view: TrendingViewProtocol?
    
    
    static func createModule() -> UIViewController {
        guard let view = TrendingViewController(
            nibName: TrendingViewController.nibName,
            bundle: nil) as? TrendingViewProtocol
        else {
            return UIViewController()
        }
        let service: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let dataManager: TrendingDataManagerInputProtocol = TrendingDataManager(providerNetworking: service)
        let interactor: TrendingInteractorInputProtocol & TrendingDataManagerOutputProtocol = TrendingInteractor()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()

        let router: TrendingRouterProtocol = TrendingViewRouter()
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
        guard let view = view as? UIViewController,
              let errorPageVC = ErrorPageRouter.createModule(errorType: errorType, titleNavBar: .trendingTitle) as? UIViewController else { return }
        view.guaranteeMainThread {
            view.navigationController?.pushViewController(errorPageVC, animated: true)
        }
        
    }
    
}
