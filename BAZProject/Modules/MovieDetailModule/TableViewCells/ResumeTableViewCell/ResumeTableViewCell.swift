//
//  ResumeTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 16/02/23.
//

import UIKit

final class ResumeTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: ResumeTableViewCell.self)
    @IBOutlet weak var overviewTextView: UILabel!
}
