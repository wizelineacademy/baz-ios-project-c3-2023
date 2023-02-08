//
//  SearchMovieRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieRouter: RouterProtocols{
    typealias Router = SearchMovieRouter
    
    static func createLoginModule() -> UIViewController {
        let viewController = SearchStoryboard.instantiateViewController(withIdentifier: "SearchMovie")
        if let view = viewController as? SearchMovieView{
            let interceptor: SearchMovieInterceptorInputProtocol = SearchMovieInterceptor()
            let presenter: SearchMoviePresenterProtocol & SearchMovieInterceptorOutputProtocol  = SearchMoviePresenter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interceptor = interceptor
            interceptor.presenter = presenter
            return view
        }
        return UIViewController()
    }
    
    static var SearchStoryboard: UIStoryboard{
        return UIStoryboard(name: "SearchMovie", bundle: Bundle.main)
    }
}
