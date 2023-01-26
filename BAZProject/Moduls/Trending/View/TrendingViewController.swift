//
//  TrendingViewController+HeaderBarViewControllerDelegate.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController, TrendingViewProtocol {
    
    var movies: [MovieResult] = []
    let mediaType: MediaType = .movie
    let movieApi = MovieAPI()

    var presenter: TrendingPresenterProtocol?
    static let nibName = "TrendingViewController"
    
    @IBOutlet weak var heightNavbarView: NSLayoutConstraint!
    @IBOutlet weak var navbarView: HeaderBarViewController!
    @IBOutlet weak var errorUIView: ErrorPageViewController!
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        errorUIView.delegate = self
        moviesTableView.register(CellMovie.nib(), forCellReuseIdentifier: CellMovie.identifier)
        getData()
        navbarView.delegate = self
        navbarView.setData(title: .trendingTitle, urlImageView: .urlLogo, width: view.bounds.width)
    }

    func getData() {
        self.view.showLoader()
        movieApi.getTrendingMedia(mediaType: mediaType,
                                  timeWindow: .day,
                                  completion: { success, resultMovies in
            self.showErrorPage(showErrorPage: success)
            self.view.removeLoader()
            if success {
                self.movies = resultMovies ?? []
                self.moviesTableView.reloadData()
            }
        })
    }
    
    func showErrorPage(showErrorPage: Bool) {
        self.moviesTableView.isHidden = !showErrorPage
        self.errorUIView.isHidden = showErrorPage
    }
    
}
