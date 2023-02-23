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
    
    class func initReviewView() -> UIView {
        guard let review = Bundle.main.loadNibNamed("ReviewView", owner: self, options: nil)?.first as? ReviewView else { return UIView() }
        return review
    }
    
}