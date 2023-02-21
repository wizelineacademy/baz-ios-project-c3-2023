//
//  SearchMovieRouter.swift
//  BAZProject
//
//  Created by hlechuga on 03/02/23.
//

import Foundation
import UIKit

class SearchMovieRouter {
    // MARK: Properties
    weak var viewController: UIViewController?
    
    //MARK: - Functions
    static func createModule() -> UIViewController {
        let view = SearchMovieView()
        let interactor = SearchMovieInteractor()
        let router = SearchMovieRouter()
        let presenter = SearchMoviePresenter(view: view,
                                             interactor: interactor,
                                             router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
}

//MARK: - Extensions
extension SearchMovieRouter: SearchRouterProtocol {
    
}
