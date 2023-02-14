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

        let interactor: DetailInteractorInputProtocol = DetailInteractor()
        let presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
        let router: DetailRouterProtocol = DetailRouter()

        view.presenter = presenter
        view.detailType = detailType
        router.view = view
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router

        guard let view = view as? UIViewController else { return UIViewController() }
        return view
    }
}
