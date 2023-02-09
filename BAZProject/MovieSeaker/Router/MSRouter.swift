//
//  MSRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSRouter {
    let view: UIViewController
    var presenter: MSPresenter?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    class func getEntry(with provider: MSProviderProtocol) -> UIViewController {
        let view = MovieSeakerView()
        let router = MSRouter(view: view)
        let interactor = MSInteractor(provider: provider)
        let presenter = MSPresenter(
            view: view,
            router: router,
            interactor: interactor)
        
        view.eventHandler = presenter
        interactor.output = presenter
        router.presenter = presenter
        
        return view
    }
    
    func goNext(_ viewController: UIViewController) {
        self.view.navigationController?.pushViewController(viewController, animated: true)
    }
}
