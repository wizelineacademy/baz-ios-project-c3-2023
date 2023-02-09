//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by nsanchezj on 02/02/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerViewMovie: UIView!
    @IBOutlet weak var stackContainerMovie: UIStackView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
