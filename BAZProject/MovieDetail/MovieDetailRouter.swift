//
//  MovieDetailRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    static func createLoginModule() -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetail")
        if let view = viewController as? MovieDetailView{
            let interceptor : MovieDetailInterceptorInputProtocol = MovieDetailInterceptor()
            let presenter : MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
            let router : MovieDetailRouterProtocol = MovieDetailRouter()
            
            view.presenter = presenter
            interceptor.presenter = presenter
            presenter.interceptor = interceptor
            presenter.view = view
            presenter.router = router
            return view
        }
        
        return UIViewController()
    }
    
    func presentView(from view: MovieDetailViewProtocol) {
        
    }
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
    }
    
}
