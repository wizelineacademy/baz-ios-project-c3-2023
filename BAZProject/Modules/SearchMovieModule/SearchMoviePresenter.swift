//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMoviePresenter: NSObject {
    weak var view: SearchMovieViewProtocol?
    var interceptor: SearchMovieInterceptorInputProtocol?
}

extension SearchMoviePresenter: SearchMoviePresenterProtocol {
    func goToMovieDetail(data: Result) {
        guard let view = view as? UIViewController else { return }
        MovieDetailRouter().presentView(from: view, data: data)
    }
    
    func viewDidLoad(collection: UICollectionView) {
        registerCollectionViewCell(collection: collection)
    }
    
    private func registerCollectionViewCell(collection: UICollectionView) {
        let cell = UINib(nibName: "GenericCollectionViewCell", bundle: nil)
        collection.register(cell, forCellWithReuseIdentifier: GenericCollectionViewCell.reusableIdentifier)
    }
    
    func getKeywordSearch(keyword:String) {
        interceptor?.getKeywordSearch(keyword: keyword)
    }
    
    func getTableViewDataSource() -> UICollectionViewDataSource {
        return self
    }
    
    func getTableViewDelegate() -> UICollectionViewDelegate {
        return self
    }
    
    func getUISearchBarDelegate() -> UISearchBarDelegate {
        return self
    }
}

extension SearchMoviePresenter: SearchMovieInterceptorOutputProtocol{
    func reloadData() {
        view?.reloadData()
    }
}

extension SearchMoviePresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let getCount = interceptor?.movieApiData.getDataMovies as? SearchMovieData{
            return getCount.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell,
            let dataMovies = interceptor?.movieApiData.getDataMovies as? SearchMovieData {
            
            cell.title.text = dataMovies.results[indexPath.row].title
            cell.imageMovie.image = UIImage(named: "poster")
            
            MovieAPI.getImage(from: dataMovies.results[indexPath.row].posterPath ?? "", handler: { imagen in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    cell.imageMovie.image = imagen
                }
            })
            return cell
        }
        return UICollectionViewCell()
    }
}

extension SearchMoviePresenter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataMovies = interceptor?.movieApiData.getDataMovies as? SearchMovieData {
            goToMovieDetail(data: dataMovies.results[indexPath.row])
        }
    }
}

extension SearchMoviePresenter: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.getKeywordSearch(keyword: searchText)
        }
    }
}
