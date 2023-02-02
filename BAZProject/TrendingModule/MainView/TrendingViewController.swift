//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {

    var movies: [ResultMovie] = []
    let manageImgs = LoadRemotedata()

    @IBOutlet var tableMoviesView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieApi = MovieAPI()
        
        movieApi.getMovies(completion: { result in
            switch result {
            case .success(let arrayMovies):
                if arrayMovies.count > 0 {
                    DispatchQueue.main.async {
                        self.movies = arrayMovies
                        self.manageImgs.saveImages(from: self.movies)
                        self.registerTableViewCells()
                        self.tableMoviesView.reloadData()
                    }
                }
            case .failure(_):
                print("Error")
            }
        })
        
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
        cell.lblMovieRate.text = RateViewModel(movieRate: movies[indexPath.row].voteAverage ).movieEmojiRate.rawValue
        cell.imgImageMovie.image = manageImgs.loadImgsFromLocal(strPath: movies[indexPath.row].posterPath)
        return cell
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailTrendingViewController()
        vc.objectMovie = movies[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120.0
        
    }
}
