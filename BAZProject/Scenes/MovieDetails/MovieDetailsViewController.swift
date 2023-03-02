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
    func displayReview(viewModel: MovieDetails.FetchReview.ViewModel)
    func displayAlertError(viewModel: MovieDetails.ErrorDisplay.ViewModel)
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
    let manager = CarruselCollectionManager<CastSearch>()
    
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
        section.heightAnchor.constraint(equalToConstant: 250).isActive = true
        let carruselCollection = CarruselCollectionView(direction: .horizontal)
        manager.setupCollection(collection: carruselCollection, delegate: nil)
        
        section.title = "Cast"
        section.setContentView(view: carruselCollection)
        
        scrollViewContainer.addArrangedSubview(section)
        manager.dataCollection = cast

    }
    
    private func addMoviesSectionView(moviesSection: MoviesSectionView) {
        moviesSection.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        scrollViewContainer.addArrangedSubview(moviesSection)
    }
    
    private func addReviewsViewToView(review: Review) {
        let section = InfoSection()
        
        section.title = "Review"
        let view = createReviewView(review: review)
        section.setContentView(view: view)

        scrollViewContainer.addArrangedSubview(section)
    }
    
    private func createReviewView(review: Review) -> UITextView {
        let descriptionView = UITextView()
    
        descriptionView.isScrollEnabled = false
        descriptionView.isEditable = false
        
        descriptionView.text = "\(review.content ?? "") \n\n by: \(review.author?.capitalized ?? "")"
        
        return descriptionView
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {

    func displayView(viewModel: MovieDetails.LoadView.ViewModel) {
        posterImageView.byURL(path: viewModel.movie.imageURL)
        addOverviewSection(description: viewModel.movie.description)
        interactor?.fetchCast(request: MovieDetails.FetchCast.Request(idMovie: viewModel.movie.id))
        
    }
    
    func displaySimilarMovies(viewModel: MovieDetails.FetchSimilarMovies.ViewModel) {
        if viewModel.movies.count != 0 {
            DispatchQueue.main.async { [weak self] in
                let moviesSectionView = MoviesSectionView(typeSection: .bySimilarMovie(id: viewModel.idMovie))
                moviesSectionView.delegate = self
                self?.addMoviesSectionView(moviesSection: moviesSectionView)
                moviesSectionView.model = viewModel.movies
            }
        }
        interactor?.fetchRecommendMovies(request: MovieDetails.FetchRecommendMovies.Request(idMovie: viewModel.idMovie))

    }
    
    func displayRecommendMovies(viewModel: MovieDetails.FetchRecommendMovies.ViewModel) {
        if viewModel.movies.count != 0 {
            DispatchQueue.main.async { [weak self] in
                let moviesSectionView = MoviesSectionView(typeSection: .byRecommendationMovie(id: viewModel.idMovie))
                moviesSectionView.delegate = self
                self?.addMoviesSectionView(moviesSection: moviesSectionView)
                moviesSectionView.model = viewModel.movies
            }
        }
    }
    
    func displayCast(viewModel: MovieDetails.FetchCast.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.addCastViewToView(cast: viewModel.cast)
        }
        interactor?.fetchReview(request: MovieDetails.FetchReview.Request(idMovie: viewModel.idMovie))
    }
    
    func displayReview(viewModel: MovieDetails.FetchReview.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            if let review = viewModel.review {
                self?.addReviewsViewToView(review: review)
            }
        }
        interactor?.fetchSimilarMovies(request: MovieDetails.FetchSimilarMovies.Request(idMovie: viewModel.idMovie))
    }
    
    func displayAlertError(viewModel: MovieDetails.ErrorDisplay.ViewModel) {
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

extension MovieDetailsViewController: MoviesSectionDelegate {
    func didTapSeeMore(section: fetchMoviesTypes, movies: [MovieSearch]) {
        router?.routeToMoviesBySection(section: section, movies: movies)
    }
    
    func didTapItemCollection(movie: MovieSearch) {
        router?.routeToMovieDetails(movie: movie)
    }
}
