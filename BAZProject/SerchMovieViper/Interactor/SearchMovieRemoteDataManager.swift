//
//  SearchMovieRemoteDataManager.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//  
//

import Foundation

class SearchMovieRemoteDataManager:SearchMovieRemoteDataManagerInputProtocol {
  
    var remoteRequestHandler: SearchMovieRemoteDataManagerOutputProtocol?
    
    private let apiKey : String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    private let movieApi : MovieAPI = MovieAPI()
    
    func getKeyword(keyword: String) {
        if let url = URLBuilder.getUrl(urlType: .keyword, searchTerm: keyword) {
            movieApi.getKeyword(for: url) { [weak self] keyword in
                if let keyword = keyword {
                    self?.remoteRequestHandler?.pushKeyword(keyword: keyword)
                }
            }
        }
    }
    
    func getSearched(searchTerm: String) {
        if let url = URLBuilder.getUrl(urlType: .search, searchTerm: searchTerm) {
            movieApi.getSearch(for: url) { [weak self] searchedMovies in
                if let searchedMovies = searchedMovies {
                    self?.remoteRequestHandler?.pushSearchedMovies(searchedMovies: searchedMovies)
                } else {
                    self?.remoteRequestHandler?.pushNotSearched()
                }
            }
        }
    }
    
}
