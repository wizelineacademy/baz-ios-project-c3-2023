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
    func displaySimilarMovies(viewModel: MovieDetails.FetchSimilarMovies.ViewModel)
    func displayRecommendMovies(viewModel: MovieDetails.FetchRecommendMovies.ViewModel)
    func displayCast(viewModel: MovieDetails.FetchCast.ViewModel)
}

class MovieDetailsViewController: UIViewController {
    
    // MARK: Properties
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    var scrollViewContainer: UIStackView = {
        let stackView = UIStackView()
       
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    var posterImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    
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
        configurateView()
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
    
    private func configurateView() {
        addScrollViewToView()
        addScrollViewContainer()
        addPosterImageViewToScrollView()
    }
    
    private func addScrollViewToView() {
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addScrollViewContainer() {
        scrollView.addSubview(scrollViewContainer)
        
        NSLayoutConstraint.activate([
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func addPosterImageViewToScrollView() {
        posterImageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.7).isActive = true
        scrollViewContainer.addArrangedSubview(posterImageView)
    }
    
    private func addOverviewSection(description: String) {
        let section = InfoSection()
        let descriptionView = UITextView()
        
        descriptionView.isScrollEnabled = false
        descriptionView.isEditable = false
        
        section.title = "Overview"
        descriptionView.text = description
        
        section.setContentView(view: descriptionView)
        scrollViewContainer.addArrangedSubview(section)
    }
    
    private func addCastViewToView(cast: [CastSearch]) {
        let section = InfoSection()
        section.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        let carruselCollection = CarruselCollectionView(direction: .horizontal)
        let manager = CarruselCollectionManager<CastSearch>()
        manager.setupCollection(collection: carruselCollection, delegate: self)
        
        section.title = "Cast"
        section.setContentView(view: carruselCollection)
        
        scrollViewContainer.addArrangedSubview(section)
        manager.dataCollection = cast

    }
    
    private func addMoviesSectionView(moviesSection: MoviesSectionView) {
        moviesSection.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        scrollViewContainer.addArrangedSubview(moviesSection)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {

    func displayView(viewModel: MovieDetails.LoadView.ViewModel) {
        posterImageView.byURL(path: viewModel.imageURL)
        addOverviewSection(description: viewModel.overview)
        interactor?.fetchCast(request: MovieDetails.FetchCast.Request(idMovie: viewModel.id))
    }
    
    func displaySimilarMovies(viewModel: MovieDetails.FetchSimilarMovies.ViewModel) {
        if viewModel.movies.count != 0 {
            DispatchQueue.main.async {
                let moviesSectionView = MoviesSectionView(typeSection: .bySimilarMovie(id: viewModel.idMovie))
                self.addMoviesSectionView(moviesSection: moviesSectionView)
                moviesSectionView.model = viewModel.movies
            }
        }
        interactor?.fetchRecommendMovies(request: MovieDetails.FetchRecommendMovies.Request(idMovie: viewModel.idMovie))

    }
    
    func displayRecommendMovies(viewModel: MovieDetails.FetchRecommendMovies.ViewModel) {
        if viewModel.movies.count != 0 {
            DispatchQueue.main.async {
                let moviesSectionView = MoviesSectionView(typeSection: .byRecommendationMovie(id: viewModel.idMovie))
                self.addMoviesSectionView(moviesSection: moviesSectionView)
                moviesSectionView.model = viewModel.movies
            }
        }
    }
    
    func displayCast(viewModel: MovieDetails.FetchCast.ViewModel) {
        DispatchQueue.main.async {
            self.addCastViewToView(cast: viewModel.cast)
            self.interactor?.fetchSimilarMovies(request: MovieDetails.FetchSimilarMovies.Request(idMovie: viewModel.idMovie))
        }

    }
}

extension MovieDetailsViewController: CarruselCollectionDelegate {
    func didTap(element: CarruselCollectionItemProperties) {
        
    }
    func displayedLastItem() {
        
    }
}

extension MovieDetailsViewController: MoviesSectionDelegate {
    func didTapSeeMore(section: fetchMoviesTypes, movies: [MovieSearch]) {
        
    }
    
    func didTapItemCollection(movie: MovieSearch) {
        
    }
}
