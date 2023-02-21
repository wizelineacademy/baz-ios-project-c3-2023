//
//  HomeMoviesViewSearchExtension.swift
//  BAZProject
//
//  Created by 1014600 on 11/02/23.
//

import UIKit

// MARK: - UISearchBarDelegate
extension HomeMoviesView: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.returnKeyType = .search
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            isSearching = false
            DispatchQueue.main.async {
                self.title = "\(self.presenter?.selectedCategory?.typeName ?? MovieCategory.trending.typeName)"
                self.collectionHomeMovie.isUserInteractionEnabled = true
                self.collectionHomeMovie.reloadData()
            }
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchMovie = searchBar.text ?? ""
        searchMovie = searchMovie.folding(options: .diacriticInsensitive, locale: Locale.current).trimmingCharacters(in: .whitespaces)
        
        self.searchTerm = searchMovie

        if  !searchMovie.isEmpty {
            isSearching = true
            self.view.endEditing(true)
            presenter?.getSearchedMovies(searchTerm: self.searchTerm)
        }else{
            isSearching = false
            DispatchQueue.main.async {
                self.title = "\(self.presenter?.selectedCategory?.typeName ?? MovieCategory.trending.typeName)"
                self.collectionHomeMovie.isUserInteractionEnabled = true
                self.collectionHomeMovie.reloadData()
            }
        }
    }
}
