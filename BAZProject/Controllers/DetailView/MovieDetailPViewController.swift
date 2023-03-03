//
//  MovieDetailPViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 13/02/23.
//

import UIKit

class MovieDetailPViewController: UIViewController {
    
    // MARK: properties
    
    let defaultPoster = UIImage(named: "poster")
    let noOverview = NSLocalizedString("MDVPC.noOverview", comment: "text")
    let noReviews = NSLocalizedString("MDVPC.noReviews", comment: "text")
    let noAuthorName = NSLocalizedString("MDVPC.noAuthorName", comment: "text")
    let backButton = NSLocalizedString("MDVPC.backButtonTitle", comment: "title")
    let navbarTitle = NSLocalizedString("MDVPC.navbarTitle", comment: "title")
    let castWidth = 120
    let castHeight = 180
    let galleryWidth = 130
    let galleryHeight = 220
    let recomendationCollectionTag = 3
    var heightRowTable: CGFloat = 82
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
    var topDetail: TopDetailView?
    var castView: CastView?
    var similarMoviesView: MovieListView?
    var recommendationView: MovieListView?
    var reviewView: ReviewView?
    var movieApi = MovieAPI()
    var movieToShowDetail: Movie?
    var movieDetail: MovieDetail?
    var movieCast: [MovieCast]? {
        didSet {
            castView?.castCollection.reloadData()
        }
    }
    var similarMovies: [Movie]? {
        didSet {
            similarMoviesView?.movieCollection.reloadData()
        }
    }
    var recommendationMovies: [Movie]? {
        didSet {
            recommendationView?.movieCollection.reloadData()
        }
    }
    var movieReviews: [MovieReview]? {
        didSet {
            reviewView?.reviewTable.reloadData()
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationToCounter()
        configNavBar()
        setUpView()
        services()
    }
    
    // MARK: Methods
    
    func notificationToCounter() {
        let notificationDetail = Notification.Name(rawValue: deltailMovieSeen)
        NotificationCenter.default.post(name: notificationDetail, object: nil)
    }
    
    func configNavBar() {
        let backButtonItem = UIBarButtonItem()
        backButtonItem.title = backButton
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButtonItem
        self.title = navbarTitle
    }
    
    func setUpView() {
        createScrollView()
        createStack()
        createTopDetail()
        createCastView()
        createSimilarMovies()
        createRecommendation()
        createReviewView()
    }
    
    func services() {
        getMovieDetail()
        getMovieCast()
        getSimilarMovies()
        getRecommendationMovies()
        getMovieReview()
    }
    
    func getMovieDetail() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieDetail(movieID: id){ detail, error in
            if let detail = detail {
                self.movieDetail = detail
                self.topDetail?.releseDate.text = detail.releaseDate
                self.topDetail?.genre.text = detail.listGenres
                if (detail.overview == nil) || detail.overview == "" {
                    self.topDetail?.overview.text = self.noOverview
                } else {
                    self.topDetail?.overview.text = detail.overview
                }
            }
        }
    }
    
    func getMovieCast() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieCast(movieID: id) { cast, error in
            if let cast = cast,
               cast.cast.count > 0 {
                self.movieCast = cast.cast.sorted {
                    $0.order < $1.order
                }
                self.castView?.isHidden = false
            } else {
                self.castView?.isHidden = true
            }
        }
    }
    
    func getSimilarMovies() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovies(movieID: id, queryType: MovieAPI.consult.similar) { movies, error in
            if let movies = movies,
               movies.count > 0 {
                self.similarMovies = movies
                self.similarMoviesView?.isHidden = false
            } else {
                self.similarMoviesView?.isHidden = true
            }
        }
    }
    
    func getRecommendationMovies() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovies(movieID: id, queryType: MovieAPI.consult.recommendations) { movies, error in
            if let movies = movies,
               movies.count > 0  {
                self.recommendationMovies = movies
                self.recommendationView?.isHidden = false
            } else {
                self.recommendationView?.isHidden = true
            }
            
        }
    }
    
    func getMovieReview() {
        guard let id = movieToShowDetail?.id else { return }
        movieApi.getMovieReviews(movieID: id) { reviews, error in
            if let reviews = reviews,
               reviews.count > 0 {
                self.movieReviews =  reviews
            } else {
                self.reviewView?.noReview.text = self.noReviews
            }
        }
    }
    
    func createScrollView() {
        view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func createStack() {
        scrollView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func createTopDetail() {
        topDetail = TopDetailView.intitTopDetail(movie: movieToShowDetail) as? TopDetailView
        guard let topDetail = topDetail else { return }
        stack.addArrangedSubview(topDetail)
    }
    
    func createCastView() {
        castView = CastView.initCastView() as? CastView
        castView?.castCollection.register(
            UINib(nibName: MovieCastCollectionViewCell.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: MovieCastCollectionViewCell.identifier)
        castView?.castCollection.dataSource = self
        castView?.sectionTitle.text = MovieDetailSections.cast.title
        let flowLayout = cellFlowlayout(size: CGSize(width: castWidth, height: castHeight))
        castView?.castCollection.setCollectionViewLayout(flowLayout, animated: false)
        guard let castView = castView else { return }
        stack.addArrangedSubview(castView)
    }
    
    func createSimilarMovies() {
        similarMoviesView = MovieListView.initMovieCollection() as? MovieListView
        similarMoviesView?.movieCollection.register(
            UINib(nibName: MovieGalleryCollectionViewCell.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: MovieGalleryCollectionViewCell.identifier)
        similarMoviesView?.movieCollection.delegate = self
        similarMoviesView?.movieCollection.dataSource = self
        similarMoviesView?.sectionTitle.text = MovieDetailSections.similar.title
        let flowLayout = cellFlowlayout(size: CGSize(width: galleryWidth, height: galleryHeight))
        similarMoviesView?.movieCollection.setCollectionViewLayout(flowLayout, animated: false)
        guard let similarMoviesView = similarMoviesView else { return }
        stack.addArrangedSubview(similarMoviesView)
    }
    
    func createRecommendation() {
        recommendationView = MovieListView.initMovieCollection() as? MovieListView
        recommendationView?.movieCollection.register(
            UINib(nibName: MovieGalleryCollectionViewCell.nibIdentifier, bundle: nil),
            forCellWithReuseIdentifier: MovieGalleryCollectionViewCell.identifier)
        recommendationView?.movieCollection.delegate = self
        recommendationView?.movieCollection.dataSource =  self
        recommendationView?.movieCollection.tag = recomendationCollectionTag
        recommendationView?.sectionTitle.text = MovieDetailSections.recommendation.title
        let flowLayout = cellFlowlayout(size: CGSize(width: galleryWidth, height: galleryHeight))
        recommendationView?.movieCollection.setCollectionViewLayout(flowLayout, animated: false)
        guard let recommendationView = recommendationView else { return }
        stack.addArrangedSubview(recommendationView)
    }
    
    func createReviewView() {
        reviewView =  ReviewView.initReviewView() as? ReviewView
        reviewView?.reviewTable.register(
            UINib(nibName: ReviewTableViewCell.nibIdentifier, bundle: nil),
            forCellReuseIdentifier: ReviewTableViewCell.identifier)
        reviewView?.reviewTable.delegate = self
        reviewView?.reviewTable.dataSource = self
        reviewView?.movieTitle.text = movieToShowDetail?.title
        reviewView?.rating.text = movieToShowDetail?.avarageRounded
        reviewView?.stars.text = movieToShowDetail?.averageStars
        guard let reviewView = reviewView else { return }
        stack.addArrangedSubview(reviewView)
    }
    
    func cellFlowlayout(size: CGSize) -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = size
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    
    func showDetailMovieViewController(movie: Movie?) {
        let detailView = MovieDetailPViewController()
        guard let movie = movie else { return }
        detailView.movieToShowDetail = movie
        navigationController?.pushViewController(detailView, animated: true)
    }
    
}

// MARK: - CollectionView's DataSource

extension MovieDetailPViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case MovieDetailSections.cast.rawValue:
            return self.movieCast?.count ?? 0
        case MovieDetailSections.similar.rawValue:
            return self.similarMovies?.count ?? 0
        case MovieDetailSections.recommendation.rawValue:
            return self.recommendationMovies?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case MovieDetailSections.cast.rawValue:
            let castCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieCastCollectionViewCell.identifier ,
                for: indexPath) as? MovieCastCollectionViewCell
            castCell?.castName.text = movieCast?[indexPath.row].nameAndCharacter
            if let partialURLImage =  movieCast?[indexPath.row].profilePath {
                castCell?.castPhoto.fetchImage(with: partialURLImage)
            } else {
                castCell?.castPhoto.image = defaultPoster
            }
            guard let castCell = castCell else { return MovieCastCollectionViewCell() }
            return castCell
        case MovieDetailSections.similar.rawValue:
            let collectionCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieGalleryCollectionViewCell.identifier,
                for: indexPath) as? MovieGalleryCollectionViewCell
            collectionCell?.movieTitle.text = similarMovies?[indexPath.row].title
            collectionCell?.voteAvarage.text = similarMovies?[indexPath.row].averageStars
            if let partialURLImage =  similarMovies?[indexPath.row].posterPath {
                collectionCell?.movieImage.fetchImage(with: partialURLImage)
            } else {
                collectionCell?.movieImage.image = defaultPoster
            }
            guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
            return collectionCell
        case MovieDetailSections.recommendation.rawValue:
            let collectionCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MovieGalleryCollectionViewCell.identifier,
                for: indexPath) as? MovieGalleryCollectionViewCell
            collectionCell?.movieTitle.text = recommendationMovies?[indexPath.row].title
            collectionCell?.voteAvarage.text = recommendationMovies?[indexPath.row].averageStars
            if let partialURLImage =  recommendationMovies?[indexPath.row].posterPath {
                collectionCell?.movieImage.fetchImage(with: partialURLImage)
            } else {
                collectionCell?.movieImage.image = defaultPoster
            }
            guard let collectionCell = collectionCell else { return MovieGalleryCollectionViewCell() }
            return collectionCell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - CollectionView's Delegate

extension MovieDetailPViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case MovieDetailSections.similar.rawValue:
            showDetailMovieViewController(movie: similarMovies?[indexPath.row])
        case MovieDetailSections.recommendation.rawValue:
            showDetailMovieViewController(movie: recommendationMovies?[indexPath.row])
        default:
            return
        }
    }
}

// MARK: - ReviewTableView's DataSource

extension MovieDetailPViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieReviews?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewCell = tableView.dequeueReusableCell(
            withIdentifier: ReviewTableViewCell.identifier,
            for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        if let username = movieReviews?[indexPath.row].authorDetail.name,
               !username.isEmpty {
            reviewCell.authorUsername.text = username
        } else {
            reviewCell.authorUsername.text = noAuthorName
        }
        reviewCell.reviewRating.text = movieReviews?[indexPath.row].authorDetail.averageStars
        return reviewCell
    }
    
}

// MARK: - MovieDetailPViewController's Delegate

extension MovieDetailPViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRowTable
    }
    
}
