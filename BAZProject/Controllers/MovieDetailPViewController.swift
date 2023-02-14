//
//  MovieDetailPViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class MovieDetailPViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.red
        return stackView
    }()
    
    var topDetail: TopDetailView!
    var castView: CastView!
    
    var movieApi = MovieAPI()
    var movieToShowDetail: Movie?
    var movieDetail: MovieDetail?
    var movieCast: [MovieCast]? {
        didSet{
            guard let castView = castView else{ return }
            castView.castCollection.reloadData()
        }
    }
    var similarMovies: [Movie]?
    var recomendationMovies: [Movie]?
    var movieReviews: [MovieReview]?
    
    enum collections: Int {
        case cast = 1
        case similar = 2
        case recomendation = 3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        services()
    }
    
    func setUpView(){
        createScrollView()
        createStack()
        createTopDetail()
        createCastView()
    }
    
    func services(){
        getMovieDetail()
        getMovieCast()
        getSimilarMovies()
        getRecomendationMovies()
    }
    
    func getMovieDetail() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieDetail(movieID: id){ detail, error in
            if let detail = detail {
                self.movieDetail = detail
                self.topDetail.releseDate.text = detail.releaseDate
                self.topDetail.genre.text = detail.listGenres
                self.topDetail.overview.text = detail.overview
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
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
    }
    
    func createStack() {
        scrollView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func createTopDetail(){
        topDetail = TopDetailView.intitTopDetail(movie: movieToShowDetail) as? TopDetailView
        stack.addArrangedSubview(topDetail)
    }
    
    func createCastView(){
        castView = CastView.initCastView() as? CastView
        castView.castCollection.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCastPhoto")
        castView.castCollection.dataSource = self
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 120, height: 180)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        castView.castCollection.setCollectionViewLayout(flowLayout, animated: false)
        stack.addArrangedSubview(castView)
    }
    
}

// MARK: - CollectionView's DataSource

extension MovieDetailPViewController: UICollectionViewDataSource {
        
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
