//
//  TrendingTableViewCell.swift
//  BAZProject
//
//  Created by avirgilio on 30/01/23.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var imgImageMovie: UIImageView!
    
    @IBOutlet weak var lblMovieTitle: UILabel!{
        didSet{
            lblMovieTitle.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var lblMovieRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
