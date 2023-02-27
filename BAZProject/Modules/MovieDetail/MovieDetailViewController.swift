//
//  MovieDetailViewController.swift
//  BAZProject
//
//  Created by 1029187 on 22/02/23.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var presenter: MovieDetailPresenterProtocol?

    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.notifyViewLoaded()
        // Do any additional setup after loading the view.
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.lblMovieTitle.text = self.presenter?.movieDetail?.title ?? ""
            self.lblMovieOverview.text = self.presenter?.movieDetail?.overview ?? ""
        }
        if let imagePath = self.presenter?.movieDetail?.posterPath, let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imagePath)") {
            imageURL.toImage() { image in
                DispatchQueue.main.async {
                    self.imgMoviePoster.image = image
                }
            }
        } else {
        }
    }
    
}
