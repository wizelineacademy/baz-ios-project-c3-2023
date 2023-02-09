//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMoviePresenter {
    var view: SearchMovieViewProtocol?
    var interceptor: SearchMovieInterceptorInputProtocol?
}

extension SearchMoviePresenter: SearchMoviePresenterProtocol{
    func goToMovieDetail(data: Result) {
        guard let view = view as? UIViewController else {return}
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    
    func viewDidLoad() {
        registertableViewCell()
    }
    
    func registertableViewCell(){
        let cell = UINib(nibName: "SearchMovieCollectionViewCell", bundle: nil)
        view?.collectionView.register(cell, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.reusableIdentifier)
    }
    
    func getKeywordSearch(keyword:String){
        interceptor?.getKeywordSearch(keyword: keyword)
    }
    
}

extension SearchMoviePresenter: SearchMovieInterceptorOutputProtocol{
    func reloadData() {
        view?.reloadData()
    }
}
