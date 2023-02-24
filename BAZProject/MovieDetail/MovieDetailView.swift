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
    var movieDetail: MovieDetail?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {return}
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
}

//MARK: - Extensions
extension MovieDetailView: MovieDetailViewIntputProtocol {
    func loadView(from model: MovieDetail) {
        self.movieDetail = model
        DispatchQueue.main.async {
            self.tblDetailsMovie.reloadData()
        }
    }
}

//MARK: - UITableViewDetegate and DataSource
extension MovieDetailView: UITableViewDelegate {}
extension MovieDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 1:
            return "Reseña"
        case 2:
            return "Reparto"
        case 3:
            return "Peliculas Similares"
        case 4:
            return "Peliculas Recomendadas"
        case 5:
            return "Reseñas de la película"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell: PosterTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: PosterTableViewCell.identifier, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            cell.configure(with: movie?.posterImagefullPath ?? "")
            return cell
        case 1:
            guard let cell: ReviewTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
            cell.configure(with: movie?.overview ?? "")
            return cell
        case 2:
            guard let cell: CastTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            cell.configure(with: movieDetail?.credits.cast ?? [])
            return cell
        case 3:
            guard let cell: SimilarMovieTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.identifier, for: indexPath) as? SimilarMovieTableViewCell else { return UITableViewCell() }
            cell.configure(with: self.movieDetail?.similarMovies.results ?? [])
            return cell
        case 4:
            guard let cell: SimilarMovieTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.identifier, for: indexPath) as? SimilarMovieTableViewCell else { return UITableViewCell() }
            cell.configure(with: self.movieDetail?.recomendtions.results ?? [])
            return cell
        case 5:
            guard let cellReviews: ReviewsTableViewCell = tblDetailsMovie.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell else  { return UITableViewCell() }
            cellReviews.configure(with: self.movieDetail?.reviews.results ??  [])
            return cellReviews
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 300.0
        case 1:
            return 200.0
        case 2:
            return 120.0
        case 3:
            return 250.0
        case 4:
            return 250.0
        case 5:
            return 200.0
        default:
            return 50.0
        }
    }
    
}
