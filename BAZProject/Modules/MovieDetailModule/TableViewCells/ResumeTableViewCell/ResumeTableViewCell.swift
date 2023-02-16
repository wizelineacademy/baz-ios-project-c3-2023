//
//  ResumeTableViewCell.swift
//  BAZProject
//
//  Created by Leobardo Gama Muñoz on 16/02/23.
//

import UIKit

class ResumeTableViewCell: UITableViewCell {
    static let reusableCell = String(describing: ResumeTableViewCell.self)
    @IBOutlet weak var overviewTextView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
