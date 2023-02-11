//
//  MSRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSRouter {
    
    weak var view: MSViewInputProtocol?
    
    init(view: MSViewInputProtocol?) {
        self.view = view
    }
    
    class func getEntry(with provider: MSProviderProtocol) -> UIViewController {
        let view = MovieSeakerView()
        let router = MSRouter(view: view)
        let interactor = MSInteractor(provider: provider)
        let presenter = MSPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        interactor.output = presenter
        
        return view
    }
}

extension MSRouter: MSRouterProtocol {
    func goNextViewController(with movie: Movie) {
        let viewController = MDRouter.getEntry(with: movie)
        self.view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
