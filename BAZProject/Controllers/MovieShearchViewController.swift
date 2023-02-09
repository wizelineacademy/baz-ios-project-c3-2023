//
//  MovieShearchViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 08/02/23.
//

import UIKit

class MovieShearchViewController: UIViewController {
    
    @IBOutlet weak var searchMovieCollection: UICollectionView!
    @IBOutlet weak var movieSearcher: UISearchBar!
    
    var movieApi = MovieAPI()
    var moviesToShow: [Movie]?{
        didSet{
            searchMovieCollection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        movieSearcher.searchTextField.delegate = self
        registerCollectionCell()
        hideKeyboardWhenTappedAround()
    }
    
    func searchMovies(from text: String){
        movieApi.searchMovie(textEncoded: text) { movies, error in
            if let movies = movies {
                self.moviesToShow = movies
            }
        }
    }
    
    func registerCollectionCell() {
        searchMovieCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - CollectionView's DataSource

extension MovieShearchViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesToShow?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGallery", for: indexPath) as? MovieGalleryCollectionViewCell
        collectionCell?.movieTitle.text = moviesToShow?[indexPath.row].title
        collectionCell?.voteAvarage.text = moviesToShow?[indexPath.row].averageStars
        if let partialURLImage =  moviesToShow?[indexPath.row].posterPath {
            collectionCell?.movieImage.fetchImage(with: partialURLImage)
        } else {
            collectionCell?.movieImage.image = UIImage(named: "poster")
        }
        guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
        return collectionCell
    }
}

extension MovieShearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            moviesToShow = []
        }
        searchMovies(from: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton =  true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        moviesToShow = []
    }
}

extension MovieShearchViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        movieSearcher.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text  =  movieSearcher.text else { return true }
        searchMovies(from: text)
        movieSearcher.resignFirstResponder()
        return true
    }
}
