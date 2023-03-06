//
//  SearchingViewController.swift
//  BAZProject
//
//  Created by 1029187 on 28/02/23.
//

import UIKit

class SearchingViewController: UIViewController {
    var presenter: SearchingPresenterProtocol?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsCollectionView: UICollectionView!

    override func viewDidLoad() {
        searchBar.delegate = self
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self
        registerCells()
    }
    
    func registerCells() {
        resultsCollectionView.register(UINib(nibName: "SearchingResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchingResultCollectionViewCell")
    }
}

extension SearchingViewController: SearchingViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.resultsCollectionView.reloadData()
        }
    }
}

extension SearchingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.bounds.width, height: 90)
    }
}

extension SearchingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.presenter?.searchResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchingResultCollectionViewCell", for: indexPath) as? SearchingResultCollectionViewCell else { return UICollectionViewCell() }
        cell.resultModel = self.presenter?.searchResults?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter?.goToMovieDetail(of: indexPath, from: self)
    }
}

extension SearchingViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = nil
        self.presenter?.searchResults = nil
        self.resultsCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter?.searchMovies(with: searchBar.searchTextField.text)
        searchBar.resignFirstResponder()
    }
}
