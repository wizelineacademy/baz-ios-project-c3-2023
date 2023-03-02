//
//  HomeTableViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: properties
    
    let notificationDetail = Notification.Name(rawValue: deltailMovieSeen)
    let movieApi = MovieAPI()
    var heightRowTable: CGFloat = 250
    var categories = MovieAPICategory.allMovieAPICategories
    var listOfCategories: [MovieAPICategory: [Movie]] = [
        .trending: [],
        .nowPlaying: [],
        .popular: [],
        .topRated: [],
        .upcoming: [],
    ]
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
        getMovies()
    }
    
    // MARK: Methods
    
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload),
                                               name: notificationDetail, object: nil)
    }
    
    @objc
    func reload() {
        CounterSingleton.shared.addToCounter()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getMovies() {
        getCategory(category: MovieAPICategory.trending)
        getCategory(category: MovieAPICategory.nowPlaying)
        getCategory(category: MovieAPICategory.popular)
        getCategory(category: MovieAPICategory.topRated)
        getCategory(category: MovieAPICategory.upcoming)
    }
    
    func getCategory(category: MovieAPICategory) {
        let category = category
        let categoryURL = MovieCategoryURLRequestFactory(category: category)
        let sessionFetcher = MovieAPI.URLSessionFetcher(
            urlRequestFactory: categoryURL,
            decodableResultAdapter: JSONDecoderResultAdapter())
        
        sessionFetcher.fetchData() { [weak self] (movieResult: MovieAPIResult?, error: Error?) in
            if let movieResult = movieResult {
                self?.listOfCategories[category] = movieResult.results
                self?.reloadSectionInTable(index: IndexSet(integer:  category.rawValue))
            }
        }
    }

    func reloadSectionInTable(index: IndexSet) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(index, with: .none)
        }
    }
    
    func showDetailMovieViewController(sender: Any?) {
        let detailView = MovieDetailPViewController()
        guard let movieDetail =  sender as? Movie else { return }
        detailView.movieToShowDetail = movieDetail
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}

// MARK: - TableView's DataSource

extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier,
                                                 for: indexPath) as? CategoryTableViewCell
        cell?.setCollectionView()
        cell?.categoryTableCellDelegate = self
        switch indexPath.section {
        case MovieAPICategory.trending.rawValue:
            cell?.moviesToShow = listOfCategories[.trending] ?? []
        case MovieAPICategory.nowPlaying.rawValue:
            cell?.moviesToShow = listOfCategories[.nowPlaying] ?? []
        case MovieAPICategory.popular.rawValue:
            cell?.moviesToShow = listOfCategories[.popular] ?? []
        case MovieAPICategory.topRated.rawValue:
            cell?.moviesToShow = listOfCategories[.topRated] ?? []
        case MovieAPICategory.upcoming.rawValue:
            cell?.moviesToShow = listOfCategories[.upcoming] ?? []
        default:
            cell?.moviesToShow = []
        }
        return cell ?? CategoryTableViewCell()
    }
    
}

// MARK: - TableView's Delegate

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowTable
    }
    
}

// MARK: - TableViewCell's Delegate

extension HomeTableViewController: CategoryTableCellDelegate {
    
    func didSelectMovie(movieId: Int, indexRow: Int) {
        let movieToShow = Movie.searchMovieByID(movieID: movieId, listOfCategories: listOfCategories)
        showDetailMovieViewController(sender: movieToShow)
    }

}

