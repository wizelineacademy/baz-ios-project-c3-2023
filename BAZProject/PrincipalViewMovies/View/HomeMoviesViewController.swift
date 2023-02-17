//
//  HomeMoviesViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

final class HomeMoviesViewController: UIViewController {
    
    //    MARK: Outlets
    @IBOutlet weak var viewContainerTopLbls: UIView!
    @IBOutlet weak var scrollConatiner: UIScrollView!
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
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        viewContainerTopLbls.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        scrollConatiner.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        self.view.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
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
        bannerView.viewContainer.backgroundColor = UIColor(named: "DarkStar")
    }
    
    
}

extension HomeMoviesViewController: TapGestureImgMovieProtocol {
    func tapGestureImgMovie(idMovie: Int?) {
        let module = DetailsMovieViewController()
        module.specificMovie = movies.first(where: { $0.id == idMovie
        })
        self.navigationController?.pushViewController(module, animated: false)
    }
}
