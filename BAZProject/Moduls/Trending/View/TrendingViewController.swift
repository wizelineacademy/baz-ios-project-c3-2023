//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController, ErrorPageViewProtocol {
    
    var movies: [MovieResult] = []
    let mediaType: MediaType = .movie
    let movieApi = MovieAPI()
    
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
    
    func reintent() {
        getData()
    }
    
}

// MARK: - TableView's DataSource

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.identifier) as? CellMovie {
            let movie = movies[indexPath.row]
            let imageUrl: String = (movie.backdropPath ?? "").getUrlImage(sizeImage: .w500)
            cell.setData(title: movie.title ?? "", imageUrl: imageUrl)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return mediaType.getMediaTypeTitle()
    }
    
}

extension TrendingViewController: HeaderBarViewControllerDelegate {
    func resizeView(heightHeader: Double) {
        heightNavbarView.constant = heightHeader
    }
}
