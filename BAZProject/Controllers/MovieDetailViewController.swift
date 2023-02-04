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
    
    var movieToShowDetail: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
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

}
