//
//  SearchMovieInteractor.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import Foundation

class SearchMovieInteractor: SearchMovieInteractorInputProtocol {
   
    // MARK: Properties
    weak var presenter: SearchMovieInteractorOutputProtocol?
    var remoteDatamanager: SearchMovieRemoteDataManagerInputProtocol?

    func getSearched(searchTerm: String) {
        remoteDatamanager?.getSearched(searchTerm: searchTerm)
    }
    
    func getKeyword(keyword: String) {
        remoteDatamanager?.getKeyword(keyword: keyword)
    }
}

extension SearchMovieInteractor: SearchMovieRemoteDataManagerOutputProtocol {
   
    func pushKeyword(keyword: [Keyword]) {
        presenter?.pushKeyword(keyword: keyword)
    }
    
    func pushSearchedMovies(searchedMovies: [SearchMovie]) {
        presenter?.pushSearchedMovies(searchedMovies: searchedMovies)
    }
    
    func pushNotSearched() {
        presenter?.pushNotSearched()
    }
    
}
