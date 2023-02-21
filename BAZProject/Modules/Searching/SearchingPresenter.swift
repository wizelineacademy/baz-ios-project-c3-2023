//
//  SearchingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

class SearchingPresenter  {
    
    var view: SearchingViewProtocol?
    
    var interactor: SearchingInteractorInputProtocol?
    
    var router: SearchingRouterProtocol?
    
    var searchResults: [SearchResult]?
    var keywords: [Keyword]?
    
}

extension SearchingPresenter: SearchingPresenterProtocol {
    func searchMovies(with query: String) {
        self.interactor?.fetchSearchResults(with: query)
    }
    
    func notifyTextChanged(with input: String) {
        self.interactor?.fetchKeywords(with: input)
    }
}

extension SearchingPresenter: SearchingInteractorOutputProtocol {
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.searchResults = searchResults
        self.view?.reloadData()
    }
    
    func keywordsFetched(keywords: [Keyword]) {
        self.keywords = keywords
        self.view?.reloadData()
    }
}
