//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 31/01/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    override func prepareForReuse() {
        self.movieImageView.image = UIImage(named: "poster")
    }
    
    func setupMovieImage(for image: UIImage?) {
        DispatchQueue.main.async {
            self.movieImageView.clipsToBounds = true
            self.movieImageView.layer.cornerRadius = 8.0
            if let image = image {
                self.movieImageView.image = image
            } else {
                self.movieImageView.image = UIImage(named: "poster")
            }
        }
    }
}
