//
//  MovieSeakerView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MovieSeakerView: UIViewController {
    
    var output: MSViewOutputProtocol?
    var movies: [Movie] = []
    var searchBar: UISearchBar = UISearchBar()
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSeaker()
        self.setupCollection()
        self.output?.didLoadView()
    }
    
    private func setupCollection() {
        moviesCollection.dataSource = self
        moviesCollection.delegate = self
        moviesCollection.showsVerticalScrollIndicator = false
        moviesCollection.allowsMultipleSelection = false
        moviesCollection.contentInset = UIEdgeInsets(
            top: 12,
            left: MSMovieCollectionViewCell.minimumSpace,
            bottom: 0,
            right: MSMovieCollectionViewCell.minimumSpace
        )
        moviesCollection.register(MSMovieCollectionViewCell.nib, forCellWithReuseIdentifier: MSMovieCollectionViewCell.identifier)
    }
    
    private func setupSeaker() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .continue
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.becomeFirstResponder()
        searchBar.layoutSubviews()
        self.navigationItem.titleView = searchBar
    }

    
}

extension MovieSeakerView: MSViewInputProtocol {
    func setView(with data: MSEntity) {
        self.title = data.viewTitle
        MSMovieCollectionViewCell.setSizeForRow(items: data.itemsForRow)
    }
    
    func set(movies: [Movie]) {
        self.movies = movies
        self.moviesCollection.reloadData()
    }
    
    func clearSearch() {
        self.searchBar.text = ""
        self.movies = []
        self.moviesCollection.reloadData()
    }
    
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}
