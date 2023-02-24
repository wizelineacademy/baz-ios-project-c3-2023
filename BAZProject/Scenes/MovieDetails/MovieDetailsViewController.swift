//
//  MovieDetailsViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayView(viewModel: MovieDetails.LoadView.ViewModel)
}

class MovieDetailsViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var titleMovie: UILabel!
    
    // MARK: Properties VIP
    var interactor: MovieDetailsBusinessLogic?
    var router: (MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadView()
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
    
    func displayView(viewModel: MovieDetails.LoadView.ViewModel) {
        titleMovie.text = viewModel.title
    }
}
