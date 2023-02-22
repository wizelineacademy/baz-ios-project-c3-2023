//
//  DetailRouter.swift
//  BAZProject
//
//  Created by 1058889 on 14/02/23.
//

import UIKit

final class DetailRouter: DetailRouterProtocol {
    weak var view: DetailViewProtocol?
    
    static func createModule(detailType: DetailType) -> UIViewController {
        let view: DetailViewProtocol = DetailViewController(
            nibName: DetailViewController.identifier,
            bundle: nil)
        let service: NetworkingProviderProtocol = NetworkingProviderService(session: URLSession.shared)
        let dataManager: DetailDataManagerInputProtocol = DetailDataManager(providerNetworking: service)
        let interactor: DetailInteractorInputProtocol & DetailDataManagerOutputProtocol = DetailInteractor()
        let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
        let router: DetailRouterProtocol = DetailRouter()

        router.view = view
        view.presenter = presenter
        view.detailType = detailType
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
}
