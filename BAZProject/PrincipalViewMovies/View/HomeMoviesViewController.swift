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
    @IBOutlet weak var lblNumberShowMovies: UILabel!
    
    //    MARK: Vars and Constants
    var moviesPopular: [Movie] = []
    var moviesNowPlaying: [Movie] = []
    var moviesLatest: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    let bannerView: BannerMovieView = BannerMovieView()
    let notificationCenter = NotificationCenter.default
    static var countMoviesUser: Int = 0
    
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
        setUINavigation()
        setupUITrendingView()
        setDelegatesCarousels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        fetchMoviewsForTypeMovie()
        setUICarousels()
        setUIBanner()
        addNotificationObserver()
        lblNumberShowMovies.text = "Peliculas visualizadas: \(HomeMoviesViewController.countMoviesUser)"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        notificationCenter.removeObserver(self)
    }
    
    /**
     Add center notification name CountMoviesNotification to ViewController
     */
    private func addNotificationObserver() {
        let notificationName = Notification.Name("CountMoviesNotification")
        notificationCenter.addObserver(self, selector: #selector(countMovies(_:)), name: notificationName, object: nil)
    }
    
    private func setUINavigation() {
        self.title = "Movies+"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
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
    
    /// Obtains an array specific movies
    private func fetchMovies(with type: TypeMovieList) {
        movieApi.getMovies(typeMovie: type, completion: { moviesArray in
            switch type {
            case .popularity:
                self.moviesPopular = moviesArray ?? []
            case .topRated:
                self.moviesNowPlaying = moviesArray ?? []
            case .upcoming:
                self.moviesLatest = moviesArray ?? []
            }
        })
    }
    
    /**
     Consume MovieApi for each type movie and get array specific movies from fetchMovies()
     */
    private func fetchMoviewsForTypeMovie() {
        fetchMovies(with: .popularity)
        fetchMovies(with: .topRated)
        fetchMovies(with: .upcoming)
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
    
    @objc func countMovies(_ sender: Any) {
        HomeMoviesViewController.countMoviesUser += 1
        lblNumberShowMovies.text = "Peliculas visualizadas: \(HomeMoviesViewController.countMoviesUser)"
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
