//
//  SearchMovieInterceptor.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

final class SearchMovieInteractor: SearchMovieInterceptorInputProtocol {
    weak var presenter: SearchMovieInterceptorOutputProtocol?
    var movieApiData: DataHelper = DataHelper()
    
    func getKeywordSearch(keyword: String) {
        MovieAPI.getApiData(from: .searchMovie, key: keyword) { [weak self] data in
            let movies =  DecodeUtility.decode(SearchMovieData.self, from: data)
            self?.movieApiData.getDataMovies = movies
            self?.presenter?.reloadData()
        }
    }
}
