//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMoviePresenter: SearchMoviePresenterProtocol, SearchMovieInterceptorOutputProtocol {
    var view: SearchMovieViewProtocol?
    var interceptor: SearchMovieInterceptorInputProtocol?
    
    func viewDidLoad() {
        registertableViewCell()
    }
    
    func registertableViewCell(){
        let cell = UINib(nibName: "SearchMovieTableViewCell", bundle: nil)
        view?.tableView.register(cell, forCellReuseIdentifier: "SearchMovie")
    }
    
    func getKeywordSearch(keyword:String){
        interceptor?.getKeywordSearch(keyword: keyword)
    }
    
    func reloadData() {
        view?.reloadData()
    }
}
