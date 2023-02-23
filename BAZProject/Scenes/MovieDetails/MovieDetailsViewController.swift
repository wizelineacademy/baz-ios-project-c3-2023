//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    // TODO: create functions to manage display logic
}

class MovieDetailsViewController: UIViewController {
    
    // MARK: Properties VIP
    var interactor: MovieDetailsBusinessLogic?
    var router: (MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Setup
    func setup() {
        let viewController = self
        let interactor = MovieDetailsInteractor()
        let presenter = MovieDetailsPresenter()
        let router = MovieDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    // TODO: conform MovieDetailsDisplayLogic protocol
}
