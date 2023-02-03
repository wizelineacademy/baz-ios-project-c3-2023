//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

final class TrendingViewController: UITableViewController {

    private var movies: [Movie] = []
    private var movieAPI = MovieProvider(category: .nowPlaying, page: 1)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTable()
        self.requestMovies()
    }
    
    private func setupTable() {
        self.tableView.register(
            MovieTableViewCell.nib,
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
    }
    
    private func requestMovies() {
        self.title = movieAPI.viewTitle
        movieAPI.getMovies { (result: Result<[Movie], Error>) in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath)
        let movie = movies[indexPath.row]
        if let movieCell = cell as? MovieTableViewCell {
            movieCell.setCell(with: movie)
        }
        return cell
    }

}
