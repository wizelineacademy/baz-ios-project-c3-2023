//
//  TrendingViewRouter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import UIKit

final class TrendingRouter: TrendingRouterProtocol {
    weak var view: TrendingViewProtocol?
    
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
        guaranteeMainThread {
            guard let view = self.view as? UIViewController else { return }
            let errorPageVC: UIViewController = ErrorPageRouter.createModule(errorType: errorType)
            view.navigationController?.pushViewController(errorPageVC, animated: true)
        }
    }
    
    private func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
