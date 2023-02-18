//
//  TopRatedViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 02/02/23.
//

import Foundation
import UIKit

class SearchViewController: UITableViewController {

    @IBOutlet weak var searchBarMovies: UISearchBar!{
        didSet{
            searchBarMovies.returnKeyType = .done
            searchBarMovies.enablesReturnKeyAutomatically = false
            searchBarMovies.backgroundColor = .brown
            if #available(iOS 13.0, *) {
                searchBarMovies.searchTextField.leftViewMode = .never
                searchBarMovies.searchTextField.leftView = nil
                searchBarMovies.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
                searchBarMovies.searchTextField.layer.borderWidth = 1
                searchBarMovies.searchTextField.layer.cornerRadius = 12
                searchBarMovies.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
                searchBarMovies.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            searchBarMovies.placeholder = "¿Qué pelicula estás buscando?"
            searchBarMovies.searchBarStyle = .default
            searchBarMovies.tintColor = .black
            searchBarMovies.backgroundColor = .clear
        }
    }
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieApi = MovieAPI()
        
        movies = movieApi.getMovies()
        tableView.reloadData()
    }

}

// MARK: - TableView's DataSource

extension SearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension SearchViewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
