//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgMoviePoster:UIImageView!
    @IBOutlet var lblMovieTitle:UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.imgMoviePoster.image = UIImage()
        self.lblMovieTitle.text = ""
    }
    
    public func configure(withModel model : Movie){
        self.lblMovieTitle.text = model.title
        if let url = URL(string: model.posterImagefullPath) ,let data = try? Data(contentsOf: url) {
            self.imgMoviePoster.image = UIImage(data: data)
            }
    }

}
