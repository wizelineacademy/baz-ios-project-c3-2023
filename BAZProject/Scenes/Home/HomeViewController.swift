//
//  HomeViewController.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayFetchedMoives(viewModel: Home.FetchMoviesBySection.ViewModel)
    func displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel)
}

class HomeViewController: UIViewController {
    
    // MARK: Properties VIP
    var interactor: HomeBusinessLogic?
    var router: (HomeRoutingLogic)?
    
    // MARK: Properties
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    var scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollViewToView()
        interactor?.getMoviesSection()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Setup
    func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    private func addMoviesSectionView(moviesSectionView: MoviesSectionView) {
        moviesSectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        scrollViewContainer.addArrangedSubview(moviesSectionView)
    }
    
    private func addScrollViewToView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displayFetchedMoives(viewModel: Home.FetchMoviesBySection.ViewModel) {
        let moviesSectionView = MoviesSectionView(typeSection: viewModel.displayedMovies.section, delegate: self)

        addMoviesSectionView(moviesSectionView: moviesSectionView)
        moviesSectionView.model = viewModel.displayedMovies.movies
    }
    
    func displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel) {
        viewModel.displayedSections.forEach { section in
            interactor?.fetchMoviesBySection(request: Home.FetchMoviesBySection.Request(section: section))
        }
    }
}

extension HomeViewController: MoviesSectionDelegate {
    func didTapSeeMore(section: fetchMoviesTypes, movies: [MovieSearch]) {
        router?.routeToMoviesBySection(section: section, movies: movies)
    }
    
    func didTapItem() {
    }
}
