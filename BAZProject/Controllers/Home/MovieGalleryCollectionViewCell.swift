//
//  MovieGalleryCollectionViewCell.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 30/01/23.
//

import UIKit

class MovieGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: MovieImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var voteAvarage: UILabel!
    
    static let nibIdentifier = "MovieGalleryCollectionViewCell"
    static let identifier = "MovieGallery"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
