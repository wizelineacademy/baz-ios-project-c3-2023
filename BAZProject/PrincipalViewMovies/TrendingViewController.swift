//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UIViewController {
    
    @IBOutlet weak var tableViewMovies: UITableView!
    
    var movies: [Movie] = []
    var movie: Movie? = nil
    let movieApi = MovieAPI()
    var typeMovieList: TypeMovieList = .popularity
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableViewMovies.reloadData()
    }
    
    private func settingsForTableBtc() {
        tableViewMovies.delegate = self
        tableViewMovies.dataSource = self
        tableViewMovies.separatorStyle = .none
        tableViewMovies.getBundleAndRegisterCell(MovieTableViewCell.self)
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.titleMovie.text = movies[indexPath.row].title
        let url = movies[indexPath.row].getUrlImg(posterPath: movies[indexPath.row].posterPath ?? "")
        if let urlString = url { cell.imgMovie.load(url: urlString) }
        return cell
    }
    
}
