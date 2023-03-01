//
//  PopularMovieViewController.swift
//  BAZProject
//
//  Created by Mario Arceo on 23/02/23.
//

import UIKit

class PopularMovieViewController: UIViewController{
    
    var movies: [Movie] = []
    let movieApi = MovieAPI()
    var images: [UIImage] = []
    let tableHeight: CGFloat = 150

    @IBOutlet weak var moviesTable: MoviesTableViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let typeOfMovies: RequestType = .popular
        DispatchQueue.global().async { [weak self] in
            self?.movies = self?.movieApi.getMovies(ofType: typeOfMovies) ?? []
            guard let myMovies =  self?.movies else { return }
            for movie in myMovies {
                let urlString = movie.posterPath
                guard let myURL = URL(string: urlString) else { return }
                self?.images.append(self?.movieApi.downloadImage(from: myURL) ?? UIImage())
                DispatchQueue.main.async{
                    self?.moviesTable.reloadData()
                }
            }
        }
        
        self.moviesTable.reloadData()
    }
}


    // MARK: - TableView's DataSource
extension PopularMovieViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell")!
    }
}

    // MARK: - TableView's Delegate
extension PopularMovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = images[indexPath.row]
        cell.contentConfiguration = config
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getMovieDetails(view: self, movie: movies[indexPath.row], movieImage: images[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableHeight
    }
    
}
