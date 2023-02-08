//
//  MDRouter.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MDRouter {
    let view: UIViewController
    private var presenter: MDPresenter?
    
    init(view: UIViewController) {
        self.view = view
    }
    
    class func getEntry(with movie: Movie) -> UIViewController {
        let view = MovieDetailView()
        let interactor = MDInteractor(movie: movie)
        let router = MDRouter(view: view)
        let presenter = MDPresenter(
            view: view,
            router: router,
            interactor: interactor
        )
        
        router.presenter = presenter
        view.eventHandler = presenter
        interactor.output = presenter
        
        return view
    }
}
