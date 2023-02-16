//
//  HomeMoviesViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class HomeMoviesViewController: UIViewController {
    
    //    MARK: Outlets
    @IBOutlet weak var stackVerticalContainer: UIStackView!
    
    
    //    MARK: Vars and Constants
    var movies: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    var typeMovieList: TypeMovieList = .popularity
    
    let bannerView: BannerMovieView = BannerMovieView()
    let carouselView: CarouselTypeMovie = CarouselTypeMovie()
    
    //    MARK: Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies+"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
        setupUITrendingView()
    }
    
    //TODO: Set UIUX for principal view
    private func setupUITrendingView() {
        bannerView.setImageBanner(nameAsset: UIImage(systemName: "house")!)
        stackVerticalContainer.addArrangedSubview(bannerView)
        stackVerticalContainer.addArrangedSubview(carouselView)
    }
    
    private func fetchMovies() {
        movies = movieApi.getMovies(typeMovie: typeMovieList) ?? []
        carouselView.moviesType = movies
        carouselView.collectionCarouselMovies.reloadData()
    }
}
