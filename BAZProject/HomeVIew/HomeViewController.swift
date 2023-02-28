//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class HomeViewController: UIViewController {
    var movieAPI: MovieAPI?
   
    var movies: [Movie] = []
    var searchMovies: [Movie] = []
    var searchResultsController: SearchMovieController?
    @IBOutlet weak var segmentedMovies: UISegmentedControl!
    @IBOutlet weak var tblMovies: UITableView!
    
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a Movie", delegate: self)
        let searchResults = searchController.searchResultsController as? SearchMovieController
        searchResults?.searchMovieControllerDelegate = self
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    
    enum SegmentedMovies: Int, CaseIterable {
        case trending
        case nowPlaying
        case popular
        case topRated
        case upComing
        
        var title: String {
            switch self {
            case .trending:
                return "Trending"
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            case .topRated:
                return "Top Rated"
            case .upComing:
                return "Upcoming"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home Movies"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        setupTable()
        configureSegmented()
        executeMovieService(endPointService: .getTrending)
    }
    
    private func configureSegmented(){
        segmentedMovies.removeAllSegments()
        for (index, item) in SegmentedMovies.allCases.enumerated() {
            segmentedMovies.insertSegment(withTitle: item.title, at: index, animated: true)
        }
        segmentedMovies.selectedSegmentIndex = 0
    }
    
    @IBAction func segmentedControl(_ segmentedControl: UISegmentedControl) {
        let enumSegmented = SegmentedMovies.init(rawValue: segmentedControl.selectedSegmentIndex) ?? .popular
        segmentedMovies.isEnabled = false
        switch enumSegmented {
        case .trending:
            executeMovieService(endPointService: .getTrending)
        case .nowPlaying:
            executeMovieService(endPointService: .getNowPlaying)
        case .popular:
            executeMovieService(endPointService: .getPopular)
        case .topRated:
            executeMovieService(endPointService: .getTopRated)
        case .upComing:
            executeMovieService(endPointService: .getUpcoming)
        }
    }
    /// this method execute the movie api for popular Movies
    private func executeMovieService(endPointService: MovieServices) {
        movieAPI?.getMovies(endpoint: endPointService) {[weak self ] result in
            switch result {
            case .success(let response):
                self?.movies = response.results ?? []
                self?.tblMovies.reloadData()
            case .failure(let error):
                print(error)
            }
            self?.segmentedMovies.isEnabled = true
        }
    }
    
    private func setupTable(){
        tblMovies.delegate = self
        tblMovies.dataSource = self
        tblMovies.register(MovieViewCell.nib, forCellReuseIdentifier: MovieViewCell.identifier)
    }
    
    func showMoviesList(arrMovie: [Movie]) {
        let results = searchController.searchResultsController as? SearchMovieController
        results?.movies = arrMovie
        results?.collectionMovieSearch.reloadData()
    }
}

// MARK: - TableView's DataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else{return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell.setInfo(for: movie)
        return cell
    }
    
}

// MARK: - TableView's Delegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblMovies.deselectRow(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        let detailVC = DetailMovieViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: SearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
    /// this method execute the movie api for a search movie based in a text
    ///  - Parameters:
    ///  - for: is the text to search as type `String`
    func updateSearchResults(for text: String) {
        self.movieAPI?.getMovies(endpoint: .search(searchText: text, page: 1)) {[weak self] result in
            switch result {
            case .success(let response):
                self?.showMoviesList(arrMovie: response.results ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension HomeViewController: SearchMovieControllerDelegate {
    func selected(movie: Movie) {
        let detailVC = DetailMovieViewController()
        detailVC.movie = movie
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

