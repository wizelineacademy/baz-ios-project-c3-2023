//
//  ReviewsCollectionViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {
    static let reusableCell = String(describing: ReviewsCollectionViewCell.self)
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var review: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
