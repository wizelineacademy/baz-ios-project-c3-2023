//
//  DetailViewCell.swift
//  BAZProject
//
//  Created by avirgilio on 27/01/23.
//

import UIKit

class DetailViewCell: UITableViewCell {

    
    @IBOutlet weak var lblElementName: UILabel!{
        didSet{
            lblElementName.text = ""
            lblElementName.font = UIFont(name: "ArialHebrew-Bold", size: 20.0)
        }
    }
    
    @IBOutlet weak var lblElementValue: UILabel!{
        didSet{
            lblElementValue.numberOfLines = 10
            lblElementValue.font = UIFont(name: "ArialMT", size: 20.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
