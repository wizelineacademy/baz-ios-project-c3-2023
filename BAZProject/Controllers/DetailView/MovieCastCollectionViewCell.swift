//
//  MovieCastCollectionViewCell.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 07/02/23.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castPhoto: MovieImageView!
    @IBOutlet weak var castName: UILabel!
    
    static let nibIdentifier = "MovieCastCollectionViewCell"
    static let identifier =  "movieCastPhoto"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
