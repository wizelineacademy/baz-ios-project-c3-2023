//
//  ReviewTableViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 21/02/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var lblReview: UILabel!
    
    //MARK: - Properties
    static var identifier = "ReviewTableViewCell"
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with text: String) {
        self.lblReview.text = text.isEmpty ? "Sin Reseña por el momento" : text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
