//
//  MDRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MDRouter {
    
    weak var view: MDViewInputProtocol?
    
    init(view: MDViewInputProtocol?) {
        self.view = view
    }
    
    /**
     Create each needed component of the movie detail view controller and connect its references
     - Parameters:
        - provider: an object that inherits from MovieDetailProviderProtocol
     - Returns: a view controller with the detail of the received movie object
     */
    static func getEntry(with provider: MovieDetailProviderProtocol) -> UIViewController {
        let view = MovieDetailsViewController()
        let interactor = MDInteractor(provider: provider)
        let router = MDRouter(view: view)
        let presenter = MDPresenter(
            view: view,
            interactor: interactor,
            router: router
        )
        
        view.output = presenter
        view.tableViewDataSource = MDDataSource(delegate: view)
        interactor.output = presenter
        
        return view
    }
}

extension MDRouter: MDRouterProtocol {
    
    /// Push the next view controller builded with the given movie
    /// - Parameter movie: a Movie object
    func goNextViewController(with movie: Movie) {
        let provider = MovieDetailProvider(movie: movie)
        let view = MDRouter.getEntry(with: provider)
        (self.view as? UIViewController)?.navigationController?.pushViewController(view, animated: true)
    }
}
