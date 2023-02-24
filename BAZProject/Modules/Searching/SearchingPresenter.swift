//
//  SearchingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import UIKit

class SearchingPresenter {
    var view: SearchingViewProtocol?
    var interactor: SearchingInteractorInputProtocol?
    var router: SearchingRouterProtocol?
    var searchResults: [SearchResult]?
}

extension SearchingPresenter: SearchingPresenterProtocol {
    func searchMovies(with query: String?) {
        if let query = query {
            self.interactor?.fetchSearchResults(with: query)
        }
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.searchResults?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension SearchingPresenter: SearchingInteractorOutputProtocol {
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.searchResults = searchResults
        self.view?.reloadData()
    }
}
