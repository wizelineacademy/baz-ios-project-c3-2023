//
//  ViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 09/02/23.
//

import UIKit

class MovieSearchCatalogViewController: UIViewController {
    
    @IBOutlet weak var searchMovieCollection: UICollectionView!
    @IBOutlet weak var resultText: UILabel!
    
    var keywordToSearch: MovieKeyword?
    var movieApi = MovieAPI()
    var moviesToShow: [Movie]? {
        didSet {
            searchMovieCollection.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionCell()
        cellFlowlayout()
        if let keyword = keywordToSearch?.name {
            searchMovies(from: keyword)
        }
    }
    
    func registerCollectionCell() {
        searchMovieCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }
    
    func cellFlowlayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize =  CGSize(width: 130, height: 220)
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
        flowLayout.scrollDirection = .vertical
        searchMovieCollection.setCollectionViewLayout(flowLayout, animated: false)
    }
    
    func searchMovies(from text: String) {
        movieApi.searchMovie(textEncoded: text) { movies, error in
            if let movies = movies,
               movies.count > 0 {
                self.hideNoResultText()
                self.moviesToShow = movies
            } else {
                self.showNoResultText()
            }
        }
    }
    
    func showDetailMovieViewController(sender: Any?) {
        let detailView = MovieDetailPViewController()
        guard let movieDetail =  sender as? Movie else { return }
        detailView.movieToShowDetail = movieDetail
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    func showNoResultText() {
        resultText.isHidden = false
        searchMovieCollection.isHidden = true
        if let keyword = keywordToSearch?.name {
            resultText.text = "No encontramos nada relacionado con \n\"\(keyword)\".\nRecuerda que puedes buscar por palabra clave o título"
        }
    }
    
    func hideNoResultText() {
        resultText.isHidden = true
        searchMovieCollection.isHidden = false
        resultText.text = ""
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

// MARK: - CollectionView's Delegate

extension MovieSearchCatalogViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieToShow = moviesToShow?[indexPath.row]
        showDetailMovieViewController(sender: movieToShow)
    }
    
}
