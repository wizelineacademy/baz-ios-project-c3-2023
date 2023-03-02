//
//  TopRatedViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 01/02/23.
//

import UIKit

class TopRatedViewController: UITableViewController {
    
    let movieApi = MovieAPI()
    var movieImage = UIImage()
    var images: [UIImage] = []
    var movies: [Movie] = []
    let tableHeight: CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getRatedMovies()
    }
    
    func getRatedMovies() {
        DispatchQueue.global().async { [weak self] in
            self?.movies = self?.movieApi.getMovies(ofType: .topRated) ?? []
            guard let myMovies =  self?.movies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.images.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async{
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - TableView's DataSource
extension TopRatedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TopRatedTableViewCell")!
    }
    
}

// MARK: - TableView's Delegate
extension TopRatedViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = images[indexPath.row]
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getMovieDetails(view: self, movie: self.movies[indexPath.row], movieImage: self.images[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableHeight
    }
    
}
