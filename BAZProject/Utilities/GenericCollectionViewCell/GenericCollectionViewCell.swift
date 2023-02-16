//
//  SearchMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 09/02/23.
//

import UIKit

class GenericCollectionViewCell: UICollectionViewCell {
    static let reusableIdentifier = String(describing: GenericCollectionViewCell.self)
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var secondTitle: UILabel!
    
}
