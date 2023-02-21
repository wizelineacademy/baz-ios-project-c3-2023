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
        URLBuilder.shared.searchTerm = keyword
        if let url = URLBuilder.shared.getUrl(urlType: .keyword) {
            movieApi.getKeyword(for: url) { keyword in
                if let keyword = keyword {
                    self.remoteRequestHandler?.pushKeyword(keyword: keyword)
                }
            }
        }
    }
    
    func getSearched(searchTerm: String) {
        URLBuilder.shared.searchTerm = searchTerm
        if let url = URLBuilder.shared.getUrl(urlType: .search) {
            movieApi.getSearch(for: url) { searchedMovies in
                if let searchedMovies = searchedMovies {
                    self.remoteRequestHandler?.pushSearchedMovies(searchedMovies: searchedMovies)
                } else {
                    self.remoteRequestHandler?.pushNotSearched()
                }
            }
        }
    }
    
}
