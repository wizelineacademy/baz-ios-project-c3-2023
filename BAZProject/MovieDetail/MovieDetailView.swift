//
//  MovieDetailView.swift
//  BAZProject
//
//  Created by hlechuga on 16/02/23.
//

import UIKit

class MovieDetailView: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblDetailsMovie: UITableView!
    
    //MARK: - Properties
    var presenter: MovieDetailViewOutputProtocol?
    var movie: Movie?
    var movieDetail: [MovieDetailType] = []
    let defaults = UserDefaults.standard
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else { return }
        NotificationCenter.default.post(name: .didViewDetail, object: self, userInfo: ["contador" : getCounter(for: "contador")])
        presenter?.fetchModel(with: movie)
        setupView()
    }
    
    //MARK: - Functions
    private func setupView() {
        tblDetailsMovie.delegate = self
        tblDetailsMovie.dataSource = self
        tblDetailsMovie.register(PosterTableViewCell.nib(), forCellReuseIdentifier: PosterTableViewCell.identifier)
        tblDetailsMovie.register(ReviewTableViewCell.nib() , forCellReuseIdentifier: ReviewTableViewCell.identifier)
        tblDetailsMovie.register(CastTableViewCell.nib(), forCellReuseIdentifier: CastTableViewCell.identifier)
        tblDetailsMovie.register(SimilarMovieTableViewCell.nib() , forCellReuseIdentifier: SimilarMovieTableViewCell.identifier)
        tblDetailsMovie.register(ReviewsTableViewCell.nib(), forCellReuseIdentifier: ReviewsTableViewCell.identifier)
    }
    
    private func getCounter(for key: String) -> Int {
        var counter = defaults.integer(forKey: key)
        counter += 1
        defaults.set(counter, forKey: key)
        return counter
    }
    
}

//MARK: - Extensions
extension MovieDetailView: MovieDetailViewIntputProtocol {
    func loadView(from model: [MovieDetailType]) {
        self.movieDetail = model
        DispatchQueue.main.async {
            self.tblDetailsMovie.reloadData()
        }
    }
}

//MARK: - UITableViewDetegate and DataSource
extension MovieDetailView: UITableViewDelegate {
}
extension MovieDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.movieDetail.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        movieDetail[section].getTitle()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch movieDetail[indexPath.section] {
        case .moviePoster:
            guard let cell: PosterTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            cell.configure(with: movie?.posterImagefullPath ?? "")
            return cell
        case .movieReview:
            guard let cell: ReviewTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            cell.configure(with: movie?.overview ?? "")
            return cell
        case .credits:
            guard let cell: CastTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell,
                  let cast:Credits = movieDetail[indexPath.section].value() as? Credits else { return UITableViewCell() }
            cell.configure(with: cast.cast)
            return cell
        case .reviews:
            guard let cellReviews: ReviewsTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell,
                  let reviews = movieDetail[indexPath.section].value() as? Reviews else { return UITableViewCell() }
            cellReviews.configure(with: reviews.results)
            return cellReviews
        case .similarMovies:
            guard let cell: SimilarMovieTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.identifier, for: indexPath) as? SimilarMovieTableViewCell,
                  let similarMovies = movieDetail[indexPath.section].value() as? SimilarMovies else { return UITableViewCell() }
            cell.configure(with: similarMovies.results)
            return cell
        case .recomendations:
            guard let cell: SimilarMovieTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.identifier, for: indexPath) as? SimilarMovieTableViewCell,
                  let recomendations = movieDetail[indexPath.section].value() as? SimilarMovies else { return UITableViewCell() }
            cell.configure(with: recomendations.results)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.movieDetail[indexPath.section].getHeight()
    }
}
