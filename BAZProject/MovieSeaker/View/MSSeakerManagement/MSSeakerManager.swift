//
//  MSSeakerManager.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

extension MovieSeakerView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.clearSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.eventHandler?.seakMovies(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}
