//
//  CarruselMovieTableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

final class CarruselMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
