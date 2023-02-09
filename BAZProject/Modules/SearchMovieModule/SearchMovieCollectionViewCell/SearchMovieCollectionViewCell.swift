//
//  SearchMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 09/02/23.
//

import UIKit

class SearchMovieCollectionViewCell: UICollectionViewCell {
    static let reusableIdentifier = String(describing: SearchMovieCollectionViewCell.self)
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var title: UILabel!
}
