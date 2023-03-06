//
//  ReviewCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 13/02/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameReviewLabel: UILabel!
    @IBOutlet weak var reviewTextView: UITextView!
    
    func setupReviewCell(name: String?, review: String?, date: String?) {
        DispatchQueue.main.async {
            self.nameReviewLabel.text = " \(name ?? "")"
            self.reviewTextView.text = review
            self.addShadowToReview()
        }
    }
    
    func addShadowToReview() {
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 15.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
