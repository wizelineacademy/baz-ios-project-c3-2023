//
//  MovieDetailRouter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 02/02/23.
//

import UIKit

class MovieDetailRouter: RouterCreateModuleWithDataProtocol, RouterPresentViewWithDataProtocol {
    typealias Router = MovieDetailRouter
    
    static func createModule<T>(data: T) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetail")
        if let view = viewController as? MovieDetailView {
            let interactor : MovieDetailInterceptorInputProtocol = MovieDetailInteractor()
            let presenter : MovieDetailInteractorOutputProtocol & MovieDetailPresenterProtocol = MovieDetailPresenter()
            
            view.presenter = presenter
            interactor.presenter = presenter
            if let data = data as? Result { interactor.data = data }
            presenter.view = view
            presenter.interceptor = interactor
            return view
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MovieDetail", bundle: Bundle.main)
    }
}
