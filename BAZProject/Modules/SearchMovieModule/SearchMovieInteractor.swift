//
//  SearchMovieInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieInteractor: SearchMovieInterceptorInputProtocol {
    var presenter: SearchMovieInterceptorOutputProtocol?
    var movieApiData: DataHelper = DataHelper()
    
    func getKeywordSearch(keyword: String) {
        MovieAPI.getApiData(from: .searchMovie(query: keyword, page: 1)) { [weak self] data in
            do{
                let movies =  DecodeUtility.decode(SearchMovieData.self, from: data)
                self?.movieApiData.getDataMovies = movies
                self?.presenter?.reloadData()
            }
        }
    }
}
