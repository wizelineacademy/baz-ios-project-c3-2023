//
//  ListMoviesRouter.swift
//  BAZProject
//
//  Created by hlechuga on 02/02/23.
//

import Foundation
import UIKit

class ListMoviesRouter {
    
    //MARK: - Properties
    weak var viewController: UIViewController?
    
    //MARK: - Functions
    static func createModule() -> UIViewController {
        let view = ListMoviesView()
        let interactor = ListMoviesInteractor()
        let router = ListMoviesRouter()
        let presenter = ListMoviesPresenter(view: view,
                                            interactor: interactor,
                                            router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

extension ListMoviesRouter: ListMoviesRouterProtocol {
   
    func goToNextViewController(with model: Movie) {
        let viewMovieDetail = MovieDetailRouter.createModule(with: model)
        viewMovieDetail.title = model.title
        self.viewController?.navigationController?.pushViewController(viewMovieDetail, animated: true)
    }
    
    func goToSearchViewController() {
        let viewSearch = SearchMovieRouter.createModule()
        self.viewController?.navigationController?.pushViewController(viewSearch, animated: true)
    }
}


