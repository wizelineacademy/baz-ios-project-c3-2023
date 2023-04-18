//
//  CVMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 16/04/23.
//

import UIKit

class CVMovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carouselView:CVCarouselView!
    
    var parentVC:UIViewController? = nil
    
    var section:CVMovieHubViewEntitySection? {
        didSet {
            if let newSection = section {
                carouselView.refreshItems(newItems: newSection.availableMovies )
                carouselView.parentVC = self.parentVC
            }            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code                
    }
    
}
