//
//  MovieSeakerView.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MovieSeakerView: UIViewController {
    
    weak var eventHandler: MSEventHandler?
    var movies: [Movie] = []
    var searchBar: UISearchBar
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    init() {
        self.searchBar = UISearchBar()
        super.init(nibName: String(describing: MovieSeakerView.self), bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        self.searchBar = UISearchBar()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSeaker()
        self.setupCollection()
        self.eventHandler?.didLoadView()
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
