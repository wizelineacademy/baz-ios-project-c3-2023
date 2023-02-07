//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 04/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieBackdrop: MovieImageView!
    @IBOutlet weak var detailImage: MovieImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var castCollection: UICollectionView!
    
    var movieToShowDetail: Movie?
    var movieDetail: MovieDetail?
    var movieApi = MovieAPI()
    var genres = "" {
        didSet {
            movieGenres.text = genres
        }
    }
    var movieGenresByID: [MovieGenres]? {
        didSet{
            var genresInList = ""
            movieGenresByID?.forEach({ genre in
                genresInList =  genresInList + " " + genre.name
            })
            genres = genresInList
        }
    }
    var movieCast: [MovieCast]? {
        didSet{
            castCollection.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
        getMovieDetail()
        getMovieCast()
        setCollectionView()
    }
    
    func setTopMovieInfo() {
        movieTitle.text = movieToShowDetail?.title
        if let partialURLBackdrop = movieToShowDetail?.backdropPath {
            movieBackdrop.fetchImage(with: partialURLBackdrop)
        }
        if let partialURLPoster = movieToShowDetail?.posterPath {
            detailImage.fetchImage(with: partialURLPoster)
        }
    }
    
    func getMovieDetail() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieDetail(movieID: id){ detail, error in
            if let detail = detail {
                self.movieDetail = detail
                self.movieYear.text = detail.releaseDate
                self.movieOverview.text = detail.overview
                self.movieGenresByID = detail.genres
            }
        }
    }
    
    func getMovieCast(){
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieCast(movieID: id) { cast, error in
            if let cast = cast{
                self.movieCast = cast.cast.sorted {
                    $0.order < $1.order
                }
            }
        }
    }
    
    func setCollectionView() {
        castCollection.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCastPhoto")
        setFlowLayout()
    }
    
    func setFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        self.castCollection.setCollectionViewLayout(flowLayout, animated: false)
    }

}

// MARK: - CollectionView's DataSource

extension MovieDetailViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCastPhoto", for: indexPath) as? MovieCastCollectionViewCell
        castCell?.castName.text = movieCast?[indexPath.row].name
        if let partialURLImage =  movieCast?[indexPath.row].profilePath {
            castCell?.castPhoto.fetchImage(with: partialURLImage)
        } else {
            castCell?.castPhoto.image = UIImage(named: "person")
        }
        guard let castCell = castCell else { return MovieCastCollectionViewCell() }
        return castCell
    }
}

// MARK: - CollectionView's Delegate

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
