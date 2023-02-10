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
    @IBOutlet weak var movieAvarage: UILabel!
    @IBOutlet weak var movieStarsAvarage: UILabel!
    @IBOutlet weak var movieAvarageTitle: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var castCollection: UICollectionView!
    @IBOutlet weak var similarMoviesCollection: UICollectionView!
    @IBOutlet weak var recomendationCollection: UICollectionView!
    @IBOutlet weak var reviewTableView: UITableView!
    
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
    
    var similarMovies: [Movie]? {
        didSet{
            similarMoviesCollection.reloadData()
        }
    }
    
    var recomendationMovies: [Movie]? {
        didSet{
            recomendationCollection.reloadData()
        }
    }
    
    var movieReviews: [MovieReview]? {
        didSet{
            reviewTableView.reloadData()
        }
    }
    
    enum collections: Int {
        case cast = 1
        case similar = 2
        case recomendation = 3
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
        getMovieDetail()
        registerCollectionCells()
        getMovieCast()
        getSimilarMovies()
        getRecomendationMovies()
        getMovieReview()
    }
    
    func setTopMovieInfo() {
        movieTitle.text = movieToShowDetail?.title
        movieAvarageTitle.text = movieToShowDetail?.title
        movieAvarage.text = movieToShowDetail?.voteAverage.description
        movieStarsAvarage.text = movieToShowDetail?.averageStars
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
    
    func getMovieReview() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieReviews(movieID: id) { reviews, error in
            if let reviews = reviews {
                self.movieReviews =  reviews
            }
        }
    }
    
    func registerCollectionCells() {
        castCollection.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCastPhoto")
        similarMoviesCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
        recomendationCollection.register(UINib(nibName: "MovieGalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieGallery")
    }
}

// MARK: - CollectionView's DataSource

extension MovieDetailViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case collections.cast.rawValue:
            return self.movieCast?.count ?? 0
        case collections.similar.rawValue:
            return self.similarMovies?.count ?? 0
        case collections.recomendation.rawValue:
            return self.recomendationMovies?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case collections.cast.rawValue:
            let castCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCastPhoto", for: indexPath) as? MovieCastCollectionViewCell
            castCell?.castName.text = movieCast?[indexPath.row].name
            if let partialURLImage =  movieCast?[indexPath.row].profilePath {
                castCell?.castPhoto.fetchImage(with: partialURLImage)
            } else {
                castCell?.castPhoto.image = UIImage(named: "person")
            }
            guard let castCell = castCell else { return MovieCastCollectionViewCell() }
            return castCell
        case collections.similar.rawValue:
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
        case collections.recomendation.rawValue:
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
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - CollectionView's Delegate

extension MovieDetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

// MARK: - TableView's DataSource

extension MovieDetailViewController: UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewCell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewTableViewCell
        if let username = movieReviews?[indexPath.row].authorDetail.name,
               !username.isEmpty {
            reviewCell?.authorUsername.text = username
        }else{
            reviewCell?.authorUsername.text = "Anónimo"
        }
        reviewCell?.reviewRating.text =  movieReviews?[indexPath.row].authorDetail.averageStars
        
        return reviewCell ?? ReviewTableViewCell()
    }
    
}
