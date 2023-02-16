//
//  MovieCollectionCell.swift
//  BAZProject
//
//  Created by 1014600 on 06/02/23.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell{
    
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    static var cellIdentifier: String = "MovieCollectionCell"
 
    func setupCell(movie: Movie){
        self.movieImageView.loadImage(urlStr: CellPath.imageUrl(urlString: movie.poster_path ?? "").completeImageURL)
        self.titleLabel.text = movie.title
        self.subTitleLabel.text = movie.original_title
    }
}
