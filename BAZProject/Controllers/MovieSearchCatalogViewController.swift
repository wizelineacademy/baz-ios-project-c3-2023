//
//  ViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 09/02/23.
//

import UIKit

class MovieSearchCatalogViewController: UIViewController {
    
    @IBOutlet weak var searchMovieCollection: UICollectionView!
    
    var keywordToSearch: MovieKeyword?
    var movieApi = MovieAPI()
    var moviesToShow: [Movie]? {
        didSet{
            searchMovieCollection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCell()
        if let keyword = keywordToSearch?.name {
            searchMovies(from: keyword)
        }
    }
    
    func registerCollectionCell() {
        searchMovieCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }
    
    func searchMovies(from text: String) {
        movieApi.searchMovie(textEncoded: text) { movies, error in
            if let movies = movies {
                self.moviesToShow = movies
            }
        }
    }
    
}

// MARK: - CollectionView's DataSource

extension MovieSearchCatalogViewController: UICollectionViewDataSource {
        
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
