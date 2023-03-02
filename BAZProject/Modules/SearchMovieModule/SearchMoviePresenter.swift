//
//  SearchMoviePresenter.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

final class SearchMoviePresenter: NSObject {
    weak var view: SearchMovieViewProtocol?
    var interceptor: SearchMovieInterceptorInputProtocol?
    var timer: Timer?
    let imageProvider = ImageProvider.shared
}

extension SearchMoviePresenter: SearchMoviePresenterProtocol {
    func searchBar(searchBar: UISearchBar) -> UIBarButtonItem {
        UIBarButtonItem(customView: searchBar)
    }
    
    func goToMovieDetail(data: Movie) {
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
    
    func getKeywordSearch(keyword: String) {
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
            
            setCollectionCell(cell: cell, indexPath: indexPath.row, dataMovies: dataMovies)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    private func setCollectionCell(cell: GenericCollectionViewCell, indexPath: Int, dataMovies: SearchMovieData) {
        UIView.fillSkeletons(onView: cell)
        if let image = dataMovies.results[indexPath].posterPath {
            cell.title.text = dataMovies.results[indexPath].title
            setImage(cell: cell, image: image)
        }
        
    }
    
    private func setImage(cell: GenericCollectionViewCell, image: String) {
        imageProvider.fetchImage(from: image) { image in
            UIView.removeSkeletons(onView: cell)
            cell.imageMovie.image = image
        }
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
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(userDidStopSearching), userInfo: searchText, repeats: false)
    }
    
    @objc func userDidStopSearching(timer: Timer) {
        guard let searchText = timer.userInfo as? String else { return }
        getKeywordSearch(keyword: searchText)
    }
}
