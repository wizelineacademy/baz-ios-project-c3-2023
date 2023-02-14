//
//  MSSeakerManager.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

extension MovieSeakerView: UISearchBarDelegate {
    /** Hide the keyboard  and restore the current search */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.clearSearch()
    }
    
    /** Call the output seakMovies method with the received text */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.output?.searchMovies(by: searchText)
    }
    
    /** Hide the keyboard */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}
