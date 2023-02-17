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
    
    /**
     Create each needed component of the movie seaker view controller and connect its references
     - Parameters:
        - provider: an object that inherits from the MSProviderProtocol
     - Returns: a view controller wich you can use to search a movie by any text
     */
    static func getEntry(with provider: MSProviderProtocol) -> UIViewController {
        let view = MovieSearchView()
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
    /** Show the next view controller with the detail of de received movie using the view's navigation controller */
    func goNextViewController(with movie: Movie) {
        let viewController = MDRouter.getEntry(with: movie)
        self.view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
