//
//  MLRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 03/02/23.
//

import UIKit

final class MLRouter {
    
    weak var view: MLViewInputProtocol?
    
    init(view: MLViewInputProtocol) {
        self.view = view
    }
    
    /**
     Create each needed component of the movie list view controller and connect its references
     - Parameters:
        - provider: an object that inherits from the MLProviderProtocol
     - Returns: a view controller that contains the list of movies with the received provider
     */
    class func getEntry(with provider: MLProviderProtocol) -> UIViewController {
        let view = MovieListView()
        let router = MLRouter(view: view)
        let interactor = MLInteractor(provider: provider)
        let presenter = MLPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        view.tableViewDelegate = MLTableViewManagement(eventHandler: presenter)
        interactor.output = presenter
        
        return view
    }
}

extension MLRouter: MLRouterProtocol {
    /**
     Show the next view controller with the detail of de received movie using the view's navigation controller
     */
    func goNextViewController(with movie: Movie) {
        let viewController = MDRouter.getEntry(with: movie)
        self.view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
