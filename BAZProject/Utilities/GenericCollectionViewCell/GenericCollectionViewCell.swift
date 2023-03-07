//
//  SearchMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 09/02/23.
//

import UIKit

protocol MoviesTableViewCellDelagete: AnyObject {
    func didTapped(movie: Movie)
}

class GenericCollectionViewCell: UICollectionViewCell {
    static let reusableIdentifier = String(describing: GenericCollectionViewCell.self)
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMovie.image = UIImage(named: "poster")
    }
    
}
