//
//  ReviewTableViewCell.swift
//  BAZProject
//
//  Created by Esmeralda Angeles Mendoza on 07/02/23.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var authorPhoto: UIImageView!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var reviewRating: UILabel!
    
    static let nibIdentifier = "ReviewTableViewCell"
    static let identifier = "reviewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
