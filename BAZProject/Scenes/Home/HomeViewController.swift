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
    func displayMoviesWatched(viewModel: Home.SaveMovieWatched.ViewModel)
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
    var moviesViews: [MoviesSectionView] = []
    
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
        subscribeMovieWatchObserver()
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
    
    private func subscribeMovieWatchObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(listenMovieWatchObserver(_:)), name: NSNotification.Name("movie.watch"), object: nil)
    }
    
    @objc func listenMovieWatchObserver(_ notification: Notification) {
        if let movie = notification.object as? MovieSearch {
            let request = Home.SaveMovieWatched.Request(movie: movie)
            interactor?.saveMovieWatched(request: request)
        }
    }
}

extension HomeViewController: HomeDisplayLogic {
    func displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel) {
        viewModel.displayedSections.forEach { section in
            let moviesSectionView = MoviesSectionView(typeSection: section)
            moviesSectionView.delegate = self
            addMoviesSectionView(moviesSectionView: moviesSectionView)
            moviesViews.append(moviesSectionView)
            interactor?.fetchMoviesBySection(request: Home.FetchMoviesBySection.Request(section: section))
        }
    }
    
    func displayFetchedMoives(viewModel: Home.FetchMoviesBySection.ViewModel) {
        moviesViews.forEach { moviesView in
            if moviesView.typeSection == viewModel.displayedMovies.section {
                moviesView.model = viewModel.displayedMovies.movies
            }
        }
    }
    
    func displayMoviesWatched(viewModel: Home.SaveMovieWatched.ViewModel) {
//        addMoviesSectionView(moviesSectionView: moviesWatchedView)
//        moviesWatchedView.model = viewModel.movies
    }
}

extension HomeViewController: MoviesSectionDelegate {
    func didTapItemCollection(movie: MovieSearch) {
        router?.routeToMovieDetails(movie: movie)
    }
    
    func didTapSeeMore(section: fetchMoviesTypes, movies: [MovieSearch]) {
        router?.routeToMoviesBySection(section: section, movies: movies)
    }
}

