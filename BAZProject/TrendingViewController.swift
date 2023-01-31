//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [Movie] = []
    let manageImgs = LoadRemotedata()

    @IBOutlet var tableMoviesView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieApi = MovieAPI()
        
        movies = movieApi.getMovies()
        manageImgs.saveImages(from: movies)
        self.registerTableViewCells()
        self.tableMoviesView.reloadData()
    }
    func registerTableViewCells(){
        
        let detailViewCell = UINib(nibName: "TrendingTableViewCell", bundle: nil)
        tableMoviesView.register(detailViewCell, forCellReuseIdentifier: "trendingTableViewCell")
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableMoviesView.dequeueReusableCell(withIdentifier: "trendingTableViewCell",
                                                         for: indexPath) as! TrendingTableViewCell
        
        cell.lblMovieTitle.text = movies[indexPath.row].title
        cell.lblMovieRate.text = RateViewModel(movieRate: movies[indexPath.row].vote_average ).movieEmojiRate.rawValue
        cell.imgImageMovie.image = manageImgs.loadImgsFromLocal(strPath: movies[indexPath.row].poster_path)
        return cell
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        var config = UIListContentConfiguration.cell()
//        config.text = movies[indexPath.row].title
//        config.image = manageImgs.loadImgsFromLocal(strPath: movies[indexPath.row].poster_path)
//        cell.contentConfiguration = config
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailTrendingViewController()
        vc.objMovie = movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120.0
        
    }
}
