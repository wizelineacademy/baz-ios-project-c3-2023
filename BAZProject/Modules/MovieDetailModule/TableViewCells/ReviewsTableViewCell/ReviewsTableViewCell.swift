//
//  ReviewsTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 15/02/23.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: ReviewsTableViewCell.self)
    var data: Codable?
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var review: UILabel!
}
