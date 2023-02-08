//
//  SearchMovieInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieInterceptor: SearchMovieInterceptorInputProtocol{
    var presenter: SearchMovieInterceptorOutputProtocol?
    var movieApi: MovieAPI = MovieAPI()
    
    func getKeywordSearch(keyword:String){
        movieApi.getApiData(from: .searchMovie(query: keyword, page: 1)) { [weak self] data in
            do{
                let movies =  DecodeUtility.decode(SearchMovieData.self, from: data)
                self?.movieApi.getDataMovies = movies
                self?.presenter?.reloadData()
            }
        
        }
    }
}
