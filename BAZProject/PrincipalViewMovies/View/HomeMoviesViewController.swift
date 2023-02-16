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
        setupUITrendingView()
        carouselView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
        setUICarousel()
        setUIBanner()
    }
    
    //TODO: Set UIUX for principal view
    private func setupUITrendingView() {
        bannerView.setImageBanner(nameAsset: UIImage(systemName: "house")!)
        stackVerticalContainer.addArrangedSubview(bannerView)
        stackVerticalContainer.addArrangedSubview(carouselView)
    }
    
    private func fetchMovies() {
        movieApi.getMovies(typeMovie: typeMovieList, completion: { moviesArray in
            self.movies = moviesArray ?? []
        })
    }
    
    private func setUICarousel() {
        carouselView.moviesType = movies
        carouselView.collectionCarouselMovies.reloadData()
        carouselView.lblTitleMoview.text = "Popular+"
    }
    
    private func setUIBanner() {
        let url = movies.first?.getUrlImg(posterPath: movies.first?.posterPath ?? "")
        if let urlString = url { bannerView.imageBanner.load(url: urlString) }
        bannerView.imageBanner.contentMode = .scaleAspectFill
    }
}

extension HomeMoviesViewController: TapGestureImgMovieProtocol {
    func tapGestureImgMovie() {
        let module = DetailsMovieViewController()
        self.navigationController?.pushViewController(module, animated: false)
    }
}
