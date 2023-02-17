//
//  MovieCollectionSimilarCell.swift
//  BAZProject
//
//  Created by 1014600 on 16/02/23.
//

import UIKit

class MovieCollectionSimilarCell: UICollectionViewCell{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    static var cellIdentifier: String = "MovieCollectionSimilarCell"
    
    func setupCell(movie: Movie){
        self.imageView.loadImage(urlStr: CellPath.imageUrl(urlString: movie.posterPath ?? "").completeImageURL)
        self.labelTitle.text = movie.title
    }
}
