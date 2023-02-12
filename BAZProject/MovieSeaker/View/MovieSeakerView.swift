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
    
    //MARK: - Lifecycle management
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSeaker()
        self.setupCollection()
        self.output?.didLoadView()
    }
    
    //MARK: - Settings methods
    /** Configures the UICollectionView thar shows the received movies */
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
    
    /** Configures the search bar controller */
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

//MARK: - Input methods implementation
extension MovieSeakerView: MSViewInputProtocol {
    /**
     Configure the view title and call the setSizeForRow method of the MSMovieColletionViewCell object
     - Parameters:
        - data: a MSEntity object
     */
    func setView(with data: MSEntity) {
        self.title = data.viewTitle
        MSMovieCollectionViewCell.setSizeForItem(itemsForRow: data.itemsForRow)
    }
    
    /**
     Set the movie array and reload the colletion view
     - Parameters:
        - movies: a Movie array
     */
    func set(movies: [Movie]) {
        self.movies = movies
        self.moviesCollection.reloadData()
    }
    
    /** Clear the search bar textfield and restore the collection view */
    func clearSearch() {
        self.searchBar.text = ""
        self.movies = []
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
