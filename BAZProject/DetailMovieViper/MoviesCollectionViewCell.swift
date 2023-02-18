//
//  MoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    
    func setupCell(image: UIImage?){
        DispatchQueue.main.async {
            self.movieImageView.clipsToBounds = true
            self.movieImageView.layer.cornerRadius = 15.0
            if let image = image {
                self.movieImageView.image = image
            } else {
                self.movieImageView.image = UIImage(named: "poster")
            }
           
        }
    }
}
