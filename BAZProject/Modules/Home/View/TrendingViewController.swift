//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var imagesMovies: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableview()
        movies = movieApi.getMovies()
        tableView.reloadData()
    }
    
    func configTableview(){
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Home")
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Home") as? HomeTableViewCell else { return UITableViewCell() }
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].poster_path)") { imageMovie in
            cell.setupCell(image: imageMovie ?? UIImage(), title: self.movies[indexPath.row].title)
        }
        return cell
    }
}

// MARK: - TableView's Delegate

extension TrendingViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController else {
            return
        }
        destination.movie = movies[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120.0
        
    }    
}
