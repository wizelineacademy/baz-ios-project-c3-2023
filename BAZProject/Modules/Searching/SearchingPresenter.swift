//
//  SearchingPresenter.swift
//  BAZProject
//
//  Created by 1029187 on 16/02/23.
//

import Foundation

class SearchingPresenter: SearchingPresenterProtocol, SearchingInteractorOutputProtocol {
    
    var view: SearchingViewProtocol?
    
    var interactor: SearchingInteractorInputProtocol?
    
    var router: SearchingRouterProtocol?
    
    var searchResults: [SearchResult]?
    
    func notifyViewLoaded() {
        
    }
    
    func searchMovies(with query: String) {
        
    }
    
    func searchResultsFecthed(searchResults: [SearchResult]) {
        
    }
    
    
}
