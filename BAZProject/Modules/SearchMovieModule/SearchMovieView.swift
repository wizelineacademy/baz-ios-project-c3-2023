//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieView: UIViewController, SearchMovieViewProtocol {
    var presenter: SearchMoviePresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
    }
    
    @IBAction func goToMainMovie(){
        self.presenter?.getKeywordSearch(keyword: "")
        dismiss(animated: true)
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchMovieView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let getCount = presenter?.interceptor?.movieApiData.getDataMovies as? SearchMovieData{
            return getCount.results.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenericCollectionViewCell.reusableIdentifier, for: indexPath) as? GenericCollectionViewCell,
            let dataMovies = presenter?.interceptor?.movieApiData.getDataMovies as? SearchMovieData {
            
            cell.title.text = dataMovies.results[indexPath.row].title
            cell.imageMovie.image = UIImage(named: "poster")
            
            MovieAPI.getImage(from: dataMovies.results[indexPath.row].posterPath ?? "", handler: { imagen in
                DispatchQueue.main.async {
                    cell.imageMovie.image = imagen
                }
            })
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let dataMovies = presenter?.interceptor?.movieApiData.getDataMovies as? SearchMovieData {
            presenter?.goToMovieDetail(data: dataMovies.results[indexPath.row])
        }
    }
}

extension SearchMovieView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.presenter?.getKeywordSearch(keyword: searchText)
        }
    }
}


