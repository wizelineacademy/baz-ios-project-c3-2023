//
//  SearchMovieProtocols.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

protocol SearchMovieViewProtocol: AnyObject {
//    Presenter -> View
    var presenter: SearchMoviePresenterProtocol? { get set }
    var collectionView: UICollectionView! { get set }
    
    func reloadData()
}

protocol SearchMoviePresenterProtocol: AnyObject {
    //    View -> Presenter
    var view: SearchMovieViewProtocol? { get set }
    var interceptor: SearchMovieInterceptorInputProtocol? { get set }
    
    func viewDidLoad(collection: UICollectionView)
    func getKeywordSearch(keyword: String)
    func goToMovieDetail(data: Result)
    func getTableViewDataSource() -> UICollectionViewDataSource
    func getTableViewDelegate() -> UICollectionViewDelegate
    func getUISearchBarDelegate() -> UISearchBarDelegate
}

protocol SearchMovieInterceptorInputProtocol: AnyObject {
    // Presenter -> Interceptor
    var presenter: SearchMovieInterceptorOutputProtocol? { get set }
    var movieApiData: DataHelper { get set }
    
    func getKeywordSearch(keyword: String)
}

protocol SearchMovieInterceptorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func reloadData()
}
