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
    func displayAlertError(viewModel: Home.ErrorFetch.ViewModel)
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
        interactor?.subscribeMovieWatchObserver()
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
    func displaySectionViews(viewModel: Home.GetMoviesSection.ViewModel) {
        viewModel.displayedSections.enumerated().forEach { (index, section) in
            let moviesSectionView = MoviesSectionView(typeSection: section)
            
            moviesSectionView.delegate = self
            addMoviesSectionView(moviesSectionView: moviesSectionView)
            moviesViews.append(moviesSectionView)
            moviesSectionView.isHidden = index == 0 ? true : false
            moviesSectionView.showSeeMore = index == 0 ? false : true
            
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
        moviesViews[0].model = viewModel.movies
        moviesViews[0].isHidden = false
    }
    
    func displayAlertError(viewModel: Home.ErrorFetch.ViewModel) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Fetch Error", message: viewModel.message, preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                self?.dismiss(animated: true)
            }
            
            alert.addAction(acceptAction)
            
            self.present(alert, animated: true)
        }
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

