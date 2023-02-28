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
    func displaySimilarMovies(viewModel: MovieDetails.SimilarMovies.ViewModel)
}

class MovieDetailsViewController: UIViewController, MoviesSectionDelegate {
    func didTapSeeMore(section: fetchMoviesTypes, movies: [MovieSearch]) {
        
    }
    
    func didTapItemCollection(movie: MovieSearch) {
        
    }
    
    
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
    var idMovie: Int?

    
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
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.fetchSimilarMovies(request: MovieDetails.SimilarMovies.Request(idMovie: idMovie ?? -1))
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
    
    private func addMoviesSectionView(moviesSection: MoviesSectionView) {
        moviesSection.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
        scrollViewContainer.addArrangedSubview(moviesSection)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {

    func displayView(viewModel: MovieDetails.LoadView.ViewModel) {
        posterImageView.byURL(path: viewModel.imageURL)
        addOverviewSection(description: viewModel.overview)
        idMovie = viewModel.id
    }
    
    func displaySimilarMovies(viewModel: MovieDetails.SimilarMovies.ViewModel) {
        DispatchQueue.main.async {
            let moviesSectionView = MoviesSectionView(typeSection: .bySimilarMovie(id: self.idMovie ?? -1))
            self.addMoviesSectionView(moviesSection: moviesSectionView)
            moviesSectionView.model = viewModel.movies
        }
    }
}
