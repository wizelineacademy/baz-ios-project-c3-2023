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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
        getMovieDetail()
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

}
