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
    
    @IBOutlet weak var buttonsearch: UIBarButtonItem!{
        didSet{
            buttonsearch.title = ""
        }
    }
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
    
    @IBAction func actionButtonSearch(_ sender: Any) {
        let vc = SearchViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableMoviesView.dequeueReusableCell(withIdentifier: "trendingTableViewCell",
                                                          for: indexPath) as? TrendingTableViewCell else {
            return UITableViewCell()
        }
        cell.loadMoviesInfo(arrayMovies: movies, index: indexPath)
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
