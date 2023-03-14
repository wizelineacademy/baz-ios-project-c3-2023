//
//  OverviewTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 03/03/23.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var overViewText: UITextView!
    
    func loadText(text: String) {
        overViewText.text = text
    }
}
