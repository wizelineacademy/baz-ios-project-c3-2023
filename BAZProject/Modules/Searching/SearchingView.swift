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
    }
}

extension SearchingViewController {
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}


extension SearchingViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension SearchingViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.presenter?.nofitySearchTextChanged()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
