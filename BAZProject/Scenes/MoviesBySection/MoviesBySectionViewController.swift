//
//  MoviesBySectionViewController.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation
import UIKit
protocol MoviesBySectionDisplayLogic: AnyObject {
    
}

class MoviesBySectionViewController: UIViewController, MoviesBySectionDisplayLogic {
    
    var interactor: MoviesBySectionBusinessLogic?
    var router: (MoviesBySectionRoutingLogic & MoviesBySectionDataPassing)?
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Setup
    func setup() {
        let viewController = self
        let interactor = MoviesBySectionInteractor()
        let presenter = MoviesBySectionPresenter()
        let router = MoviesBySectionRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}
