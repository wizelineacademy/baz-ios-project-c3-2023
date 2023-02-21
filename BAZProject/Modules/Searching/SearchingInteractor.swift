//
//  SearchingInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

class SearchingInteractor {
    var presenter: SearchingInteractorOutputProtocol?
    
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol?
}

extension SearchingInteractor: SearchingInteractorInputProtocol {
    func fetchSearchResults(with query: String) {
        self.remoteDatamanager?.fetchSearchResults(with: query)
    }
    
    func fetchKeywords(with input: String) {
        self.remoteDatamanager?.fetchKeywords(with: input)
    }
    
}

extension SearchingInteractor: SearchingRemoteDataManagerOutputProtocol {
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.presenter?.searchResultsFecthed(searchResults: searchResults)
    }
    
    func keywordsFetched(keywords: [Keyword]) {
        self.presenter?.keywordsFetched(keywords: keywords)
    }
    
}
