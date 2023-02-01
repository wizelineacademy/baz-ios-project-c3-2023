//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    let movieApi = MovieAPI()


    override func viewDidLoad() {
        super.viewDidLoad()
        movies = movieApi.getMovies(request: RequestType.trending)
        tableView.reloadData()
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        let urlImage = movies[indexPath.row].poster_path
        guard let url = URL(string: urlImage) else {
            cell.contentConfiguration = config
            return
        }
        
        config.image = UIImage(data: try! Data(contentsOf: url))  ?? UIImage()
        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}
