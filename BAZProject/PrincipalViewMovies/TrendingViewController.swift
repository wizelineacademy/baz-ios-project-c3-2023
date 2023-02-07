//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    @IBOutlet var tableViewMovies: UITableView!
    
    var movies: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    var typeMovieList: TypeMovieList = .popularity
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUITrendingView()
        settingsForTableBtc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMovies()
    }
    
    //TODO: Set UIUX for principal view
    private func setupUITrendingView() {
    }
    
    private func fetchMovies() {
        movies = movieApi.getMovies(typeMovie: typeMovieList) ?? []
        tableView.reloadData()
    }
    
    private func settingsForTableBtc() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.separatorStyle = .none
        tableViewMovies.getBundleAndRegisterCell(MovieTableViewCell.self)
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.titleMovie.text = movies[indexPath.row].title
        let url = movies[indexPath.row].getUrlImg(posterPath: movies[indexPath.row].posterPath ?? "")
        if let urlString = url { cell.imgMovie.load(url: urlString) }
        return cell
    }

}

// MARK: - TableView's Delegate
//
extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
}
