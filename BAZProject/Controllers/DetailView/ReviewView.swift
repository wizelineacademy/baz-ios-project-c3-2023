//
//  ReviewView.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 14/02/23.
//

import UIKit

class ReviewView: UIView {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var noReview: UILabel!
    @IBOutlet weak var sectionLayer: UIView!
    
    static let nibIdentifier = "ReviewView"
    
    class func initReviewView() -> UIView {
        guard let review = Bundle.main.loadNibNamed(ReviewView.nibIdentifier,
                                                    owner: self,
                                                    options: nil)?.first as? ReviewView else { return UIView() }
        review.sectionLayer.layer.cornerRadius = 15
        review.sectionLayer.layer.maskedCorners = [.layerMaxXMinYCorner]
        return review
    }
    
}
