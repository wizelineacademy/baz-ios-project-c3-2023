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
    var moviesPopular: [Movie] = []
    var moviesNowPlaying: [Movie] = []
    var moviesLatest: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    let bannerView: BannerMovieView = BannerMovieView()
    
    /**
     this constant sets the order carousel sections
     */
    let corouselsSections: [CarouselTypeMovie] = [
        CarouselTypeMovie(), //CarouselsPopular+
        CarouselTypeMovie(), //CarouselTopRated+
        CarouselTypeMovie()  //CarouselUpcoming+
    ]
    
    //    MARK: Life cycle VC
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies+"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        setupUITrendingView()
        setDelegatesCarousels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMoviesHome()
        setUICarousels()
        setUIBanner()
    }
    
    private func setDelegatesCarousels() {
        corouselsSections.forEach { carousel in
            carousel.delegate = self
        }
    }
    
    private func setupUITrendingView() {
        viewContainerTopLbls.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        scrollConatiner.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        self.view.backgroundColor = UtilsMoviesApp.shared.colorBackgroundApp
        stackVerticalContainer.addArrangedSubview(bannerView)
        corouselsSections.forEach { carousel in
            stackVerticalContainer.addArrangedSubview(carousel)
        }
    }
    
    private func fetchMoviesHome() {
        fetchMoviesPopularity()
        fetchMoviesNowPaying()
        fetchMoviesLatest()
    }
    
    private func fetchMoviesPopularity() {
        fetchMovies(with: .popularity)
    }
    
    private func fetchMoviesNowPaying() {
        fetchMovies(with: .topRated)
    }
    
    private func fetchMoviesLatest() {
        fetchMovies(with: .upcoming)
    }
    
    /// Obtains an array specific movies
    private func fetchMovies(with type: TypeMovieList) {
        movieApi.getMovies(typeMovie: type, completion: { moviesArray in
            self.moviesPopular = moviesArray ?? []
        })
    }
    
    private func setUICarousels() {
        corouselsSections.enumerated().forEach { (index, carousel) in
            switch index {
            case TypeMovieList.popularity.getIndexTypeMovie():
                carousel.lblTitleMoview.text = TypeMovieList.popularity.getNameCarousel()
                carousel.moviesType = moviesPopular
                carousel.typeMovieListCarousel = .popularity
            case TypeMovieList.topRated.getIndexTypeMovie():
                carousel.lblTitleMoview.text = TypeMovieList.topRated.getNameCarousel()
                carousel.moviesType = moviesNowPlaying
                carousel.typeMovieListCarousel = .topRated
            case TypeMovieList.upcoming.getIndexTypeMovie():
                carousel.lblTitleMoview.text = TypeMovieList.upcoming.getNameCarousel()
                carousel.moviesType = moviesLatest
                carousel.typeMovieListCarousel = .upcoming
            default:
                carousel.lblTitleMoview.text = TypeMovieList.popularity.getNameCarousel()
                carousel.moviesType = moviesPopular
                carousel.typeMovieListCarousel = .popularity
            }
            carousel.collectionCarouselMovies.reloadData()
        }
    }
    
    private func setUIBanner() {
        let url = moviesPopular.first?.getUrlImg(posterPath: moviesPopular.first?.posterPath ?? "")
        if let urlString = url { bannerView.imageBanner.load(url: urlString) }
        bannerView.imageBanner.contentMode = .scaleAspectFill
        bannerView.viewContainer.backgroundColor = UIColor(named: "DarkStar")
    }
}

extension HomeMoviesViewController: TapGestureImgMovieProtocol {
    func tapGestureImgMovie(idMovie: Int?, typeMovieList: TypeMovieList?) {
        guard let typeMovieList = typeMovieList else { return }
        let module = DetailsMovieViewController()
        switch typeMovieList {
        case .popularity:
            module.specificMovie = moviesPopular.first(where: { $0.id == idMovie
            })
        case .topRated:
            module.specificMovie = moviesNowPlaying.first(where: { $0.id == idMovie
            })
        case .upcoming:
            module.specificMovie = moviesLatest.first(where: { $0.id == idMovie
            })
        }
        
        self.navigationController?.pushViewController(module, animated: false)
    }
}
