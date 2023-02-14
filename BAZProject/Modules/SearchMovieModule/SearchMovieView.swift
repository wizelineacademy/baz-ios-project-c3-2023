//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

class SearchMovieView: UIViewController {
    var presenter: SearchMoviePresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(collection: collectionView)
        getDelegates()
    }
    
    private func getDelegates(){
        collectionView.dataSource = presenter?.getTableViewDataSource()
        collectionView.delegate = presenter?.getTableViewDelegate()
        searchBar.delegate = presenter?.getUISearchBarDelegate()
    }
    
    @IBAction func goToMainMovie(){
        self.presenter?.getKeywordSearch(keyword: "")
        dismiss(animated: true)
    }
}

extension SearchMovieView: SearchMovieViewProtocol {
    func reloadData(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


