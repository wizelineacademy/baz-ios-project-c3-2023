//
//  TrendingViewController.swift
//  BAZProject
//
//

import UIKit

class TrendingViewController: UITableViewController {
    
    var movies: Movies?

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    private func getData(){
//        MovieAPI().getMovies(url: .topRated(page: 10)) { [weak self] data in
//            do{
//                self?.movies =  DecodeUtility.decode(Movies.self, from: data)
//                DispatchQueue.main.async{
//                    self?.tableView.reloadData()
//                }
//            }
//        }
    }
}

// MARK: - TableView's DataSource

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension TrendingViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies?.results[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
