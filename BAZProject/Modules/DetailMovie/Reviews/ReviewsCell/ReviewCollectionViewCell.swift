//
//  ReviewCollectionViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var createdLabel: UILabel!

    func setUpReviews(authorLabel: String, reviewLabel: String, createdLabel:String){
        self.authorLabel.text = authorLabel
        self.reviewText.text = reviewLabel
        self.createdLabel.text = createdLabel
    }
}
    
