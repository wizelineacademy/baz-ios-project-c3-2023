//
//  MovieSearchView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MovieSearchView: UIViewController {
    
    var output: MSViewOutputProtocol?
    var collectionDataSource: MSCollectionDataSource?
    var collectionDelegate: MSCollectionDelegate?
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    //MARK: - Lifecycle management
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSearchBar()
        self.setupCollection()
        self.output?.didLoadView()
    }
    
    //MARK: - Settings methods
    /** Configures the UICollectionView thar shows the received movies */
    private func setupCollection() {
        moviesCollection.dataSource = collectionDataSource
        moviesCollection.delegate = collectionDelegate
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
    
    /** Configures the search bar controller */
    private func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .continue
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.becomeFirstResponder()
        searchBar.layoutSubviews()
        self.navigationItem.titleView = searchBar
    }

    
}

extension MovieSearchView: MSCollectionOutputProtocol {
    func didSelectItem(at indexPath: IndexPath) {
        guard let movie = collectionDataSource?.movies[indexPath.row] else { return }
        self.output?.didSelect(movie)
    }
}

//MARK: - Input methods implementation
extension MovieSearchView: MSViewInputProtocol {
    /**
     Configure the view title and call the setSizeForRow method of the MSMovieColletionViewCell object
     - Parameters:
        - data: a MSEntity object
     */
    func setupView(with data: MSEntity) {
        self.title = data.viewTitle
        MSMovieCollectionViewCell.setSizeForItem(itemsForRow: data.itemsForRow)
    }
    
    /**
     Set the movie array and reload the colletion view
     - Parameters:
        - movies: a Movie array
     */
    func set(movies: [Movie]) {
        self.collectionDataSource?.movies = movies
        self.moviesCollection.reloadData()
    }
    
    /** Clear the search bar textfield and restore the collection view */
    func clearCollection() {
        self.collectionDataSource?.movies = []
        self.moviesCollection.reloadData()
    }
    
    /**
     Show the received error in an alert components
     - Parameters:
        - error: an Error object
     */
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Movies", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(defaultAction)
        self.present(alert, animated: true)
    }
}