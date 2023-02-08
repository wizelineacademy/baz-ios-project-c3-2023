//
//  MLRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MLRouter {
    let view: UIViewController
    var presenter: MLPresenter?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    class func getEntry(with provider: MLProviderProtocol) -> UIViewController {
        let view = MovieListView()
        let router = MLRouter(view: view)
        let interactor = MLInteractor(provider: provider)
        let presenter = MLPresenter(
            interactor: interactor,
            view: view,
            router: router
        )
        
        view.eventHandler = presenter
        interactor.output = presenter
        router.presenter = presenter
        
        return view
    }
    
    func goNext(_ viewController: UIViewController) {
        self.view.navigationController?.pushViewController(viewController, animated: true)
    }
}
