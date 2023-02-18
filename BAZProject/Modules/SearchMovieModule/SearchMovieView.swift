//
//  SearchMovieView.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 07/02/23.
//

import UIKit

final class SearchMovieView: UIViewController {
    var presenter: SearchMoviePresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    private var makeView = MakeSearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(collection: collectionView)
        getDelegates()
        self.navigationItem.rightBarButtonItem = presenter?.searchBar(searchBar: makeView.searchBar)
    }
    
    private func getDelegates() {
        collectionView.dataSource = presenter?.getTableViewDataSource()
        collectionView.delegate = presenter?.getTableViewDelegate()
        makeView.searchBar.delegate = presenter?.getUISearchBarDelegate()
    }
}

extension SearchMovieView: SearchMovieViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
