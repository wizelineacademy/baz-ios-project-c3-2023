//
//  MovieDetailRouter.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation
import UIKit

class MovieDetailRouter {
    
    //MARK: - Properties
    weak var viewController: UIViewController?

    //MARK: - Functions
    static func createModule(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        view.movie = movie
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(view: view,
                                             interactor: interactor,
                                             router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

//MARK: - Extensions
extension MovieDetailRouter: MovieDetailRouterProtocol {
}


