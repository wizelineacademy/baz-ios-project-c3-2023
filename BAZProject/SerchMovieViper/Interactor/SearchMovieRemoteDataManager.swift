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
        let urlKeywordMovie = "https://api.themoviedb.org/3/search/keyword?api_key=\(apiKey)&query=\(keyword)"
        movieApi.getKeyword(for: urlKeywordMovie) { keyword in
            if let keyword = keyword{
                self.remoteRequestHandler?.pushKeyword(keyword: keyword)
            }
        }
    }
    
    func getSearched(searchTerm: String) {
        let urlSearchMovie = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(searchTerm)"
        movieApi.getSearch(for: urlSearchMovie) { searchedMovies in
            if let searchedMovies = searchedMovies{
                self.remoteRequestHandler?.pushSearchedMovies(searchedMovies: searchedMovies)
            } else {
                self.remoteRequestHandler?.pushNotSearched()
            }
        }
    }
    
}
