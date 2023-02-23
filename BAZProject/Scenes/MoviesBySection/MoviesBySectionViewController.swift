//
//  MoviesBySectionViewController.swift
//  BAZProject
//
//  Created by 1034209 on 22/02/23.
//

import Foundation
import UIKit
protocol MoviesBySectionDisplayLogic: AnyObject {
    func displayView(viewModel: MoviesBySection.LoadView.ViewModel)
    func displayFetchedMovies(viewModel: MoviesBySection.FetchMovies.ViewModel)
}

class MoviesBySectionViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moviesView: UIView!
    
    // MARK: Properties VIP
    var interactor: MoviesBySectionBusinessLogic?
    var router: (MoviesBySectionRoutingLogic & MoviesBySectionDataPassing)?
    
    // MARK: Properties
    let moviesCollection: CarruselCollectionView = CarruselCollectionView(direction: .vertical)
    let manager: CarruselCollectionManager = CarruselCollectionManager()
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMoviesCollectionView()
        interactor?.loadView()
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
    
    private func configureMoviesCollectionView() {
        manager.setupCollection(collection: moviesCollection, delegate: self)
        moviesView.addSubview(moviesCollection)
        
        moviesCollection.trailingAnchor.constraint(equalTo: moviesView.trailingAnchor).isActive = true
        moviesCollection.leadingAnchor.constraint(equalTo: moviesView.leadingAnchor).isActive = true
        moviesCollection.topAnchor.constraint(equalTo: moviesView.topAnchor).isActive = true
        moviesCollection.bottomAnchor.constraint(equalTo: moviesView.bottomAnchor).isActive = true
    }
    
}

extension MoviesBySectionViewController: MoviesBySectionDisplayLogic {
    func displayView(viewModel: MoviesBySection.LoadView.ViewModel) {
        titleLabel.text = viewModel.title
        manager.dataCollection = viewModel.movies
    }
    
    func displayFetchedMovies(viewModel: MoviesBySection.FetchMovies.ViewModel) {
        if viewModel.movies.count != 0 {
            manager.dataCollection =  (manager.dataCollection ?? []) + viewModel.movies
        }
    }
}

extension MoviesBySectionViewController: CarruselCollectionDelegate {
    func displayedLastItem() {
        interactor?.fetchMovies()
    }
}
