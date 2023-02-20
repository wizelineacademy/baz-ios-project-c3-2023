//
//  SearchingInteractor.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

class SearchingInteractor: SearchingInteractorInputProtocol, SearchingRemoteDataManagerOutputProtocol {
    var presenter: SearchingInteractorOutputProtocol?
    
    var remoteDatamanager: SearchingRemoteDataManagerInputProtocol?
    
    func fetchSearchResults(with query: String) {
        
    }
    
    func searchResultsFecthed(searchResults: [SearchResult]) {
        
    }
    
    
}
