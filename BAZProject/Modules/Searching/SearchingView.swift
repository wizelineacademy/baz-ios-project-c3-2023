//
//  SearchingView.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

class SearchingViewController: UITableViewController {
    
    var presenter: SearchingPresenterProtocol?
    @IBOutlet weak var searchBar: UISearchBar!
}

extension SearchingViewController: SearchingViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = self.presenter?.searchResults?[indexPath.row].title
        if let posterPath = self.presenter?.searchResults?[indexPath.row].posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            imageURL.toImage() { image in
                DispatchQueue.main.async {
                    config.image = image
                    cell.contentConfiguration = config
                }
            }
        } else {
            config.image = UIImage(named: "poster")
            cell.contentConfiguration = config
        }
    }
}


extension SearchingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.searchResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchingResultsTableViewCell") else { return UITableViewCell() }
        return tableViewCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.present(MovieDetailRouter.createMovieDetailModule(of: self.presenter?.searchResults?[indexPath.row].id ?? 0), animated: false)
    }
}

extension SearchingViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.searchTextField.text = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.searchMovies(with: searchBar.searchTextField.text)
    }
}
