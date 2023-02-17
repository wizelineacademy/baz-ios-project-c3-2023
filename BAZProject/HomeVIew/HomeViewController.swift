//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class HomeViewController: UIViewController, NibInstantiatable {
    let movieAPI = MovieAPI()
    var movies: [Movie] = []
    var searchMovies: [Movie] = []
    var searchResultsController: SearchMovieController?
    @IBOutlet weak var tblMovies: UITableView!
    
    lazy private var searchController: SearchBar = {
        let searchController = SearchBar("Search a Movie", delegate: self)
        let searchResults = searchController.searchResultsController as? SearchMovieController
        searchController.showsCancelButton = !searchController.isSearchBarEmpty
        return searchController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
   
       
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Home Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        setupTable()
        executeMovieService()
    }
    
    private func executeMovieService() {
        movieAPI.getMovies(endpoint: .getPopular) { result in
            switch result {
            case .success(let response):
                self.movies = response.results ?? []
                self.tblMovies.reloadData()
            case .failure(let error):
                print(error)
            }
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
        navigationController?.pushViewController(detailVC, animated: false)
    }
}

extension HomeViewController: SearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func updateSearchResults(for text: String) {
        
        self.movieAPI.searchMovie(endpoint: .search(searchText: text, page: 1)) { result in
            switch result {
            case .success(let response):
                self.showMoviesList(arrMovie: response.results ?? [])
            case .failure(let error):
                print(error)
            }
        }
    }
}


