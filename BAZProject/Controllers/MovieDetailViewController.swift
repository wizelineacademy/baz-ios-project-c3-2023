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
    @IBOutlet weak var similarMoviesCollection: UICollectionView!
    @IBOutlet weak var recomendationCollection: UICollectionView!
    
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
    
    var similarMovies: [Movie]?
    {
        didSet{
            similarMoviesCollection.reloadData()
        }
    }
    
    var recomendationMovies: [Movie]?
    {
        didSet{
            recomendationCollection.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
        getMovieDetail()
        setCollectionView()
        setRecomendationCollectionView()
        setSimilarMoviesCollectionView()
        getMovieCast()
        getSimilarMovies()
        getRecomendationMovies()
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
    
    func getSimilarMovies(){
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovies(movieID: id, queryType: MovieAPI.consult.similar) { movies, error in
            if let movies = movies {
                self.similarMovies = movies
            }
        }
    }
    
    func getRecomendationMovies(){
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovies(movieID: id, queryType: MovieAPI.consult.recommendations) { movies, error in
            if let movies = movies {
                self.recomendationMovies = movies
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
    
    func setRecomendationCollectionView(){
        similarMoviesCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }
    
    func setSimilarMoviesCollectionView(){
        recomendationCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }

}

// MARK: - CollectionView's DataSource

extension MovieDetailViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.castCollection{
            return movieCast?.count ?? 0
        } else if collectionView == self.similarMoviesCollection{
            return similarMovies?.count ?? 0
        } else if collectionView == self.recomendationCollection{
            return recomendationMovies?.count ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.castCollection{
                let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCastPhoto", for: indexPath) as? MovieCastCollectionViewCell
                castCell?.castName.text = movieCast?[indexPath.row].name
                if let partialURLImage =  movieCast?[indexPath.row].profilePath {
                    castCell?.castPhoto.fetchImage(with: partialURLImage)
                } else {
                    castCell?.castPhoto.image = UIImage(named: "person")
                }
                guard let castCell = castCell else { return MovieCastCollectionViewCell() }
                return castCell
        } else if collectionView == self.similarMoviesCollection{
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGallery", for: indexPath) as? MovieGalleryCollectionViewCell
            collectionCell?.movieTitle.text = similarMovies?[indexPath.row].title
            collectionCell?.voteAvarage.text = similarMovies?[indexPath.row].averageStars
            if let partialURLImage =  similarMovies?[indexPath.row].posterPath {
                collectionCell?.movieImage.fetchImage(with: partialURLImage)
            } else {
                collectionCell?.movieImage.image = UIImage(named: "poster")
            }
            guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
            return collectionCell
        } else if collectionView == self.recomendationCollection {
            let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGallery", for: indexPath) as? MovieGalleryCollectionViewCell
            collectionCell?.movieTitle.text = recomendationMovies?[indexPath.row].title
            collectionCell?.voteAvarage.text = recomendationMovies?[indexPath.row].averageStars
            if let partialURLImage =  recomendationMovies?[indexPath.row].posterPath {
                collectionCell?.movieImage.fetchImage(with: partialURLImage)
            } else {
                collectionCell?.movieImage.image = UIImage(named: "poster")
            }
            guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
            return collectionCell
        }
        return UICollectionViewCell()
    }
}

// MARK: - CollectionView's Delegate

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
