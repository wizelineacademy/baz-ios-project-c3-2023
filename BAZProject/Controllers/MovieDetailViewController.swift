//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 04/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieBackdrop: UIImageView!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    var movieToShowDetail: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTopMovieInfo()
    }
    
    func setTopMovieInfo(){
        movieTitle.text = movieToShowDetail?.title
    }

}
