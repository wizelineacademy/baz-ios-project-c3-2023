//
//  KeywordTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 16/02/23.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    @IBOutlet weak var keywordLabel: UILabel!
    
    func setupCell(keyword: String) {
        self.keywordLabel.text = keyword
    }
}
