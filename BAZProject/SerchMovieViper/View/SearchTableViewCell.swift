//
//  SearchTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 15/02/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageview: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var searchedContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(image: UIImage?, name: String){
        DispatchQueue.main.async {
            self.movieImageview.clipsToBounds = true
            self.movieImageview.layer.cornerRadius = 15.0
            if let image = image{
                self.movieImageview.image = image
            } else {
                self.movieImageview.image = UIImage(named: "poster")
            }
            self.nameMovieLabel.text = name
            self.addShadow()
        }
    }
    
    func addShadow(){
        searchedContentView.layer.borderWidth = 5.0
        searchedContentView.layer.borderColor = UIColor.clear.cgColor
        searchedContentView.layer.masksToBounds = true
        
        // cell shadow section
        searchedContentView.layer.cornerRadius = 15.0
        searchedContentView.layer.borderWidth = 5.0
        searchedContentView.layer.borderColor = UIColor.clear.cgColor
        searchedContentView.layer.masksToBounds = true
        searchedContentView.layer.shadowColor = UIColor.black.cgColor
        searchedContentView.layer.shadowOffset = CGSize(width: 0, height: 0.0)
        searchedContentView.layer.shadowRadius = 6.0
        searchedContentView.layer.shadowOpacity = 0.6
        searchedContentView.layer.cornerRadius = 15.0
        searchedContentView.layer.masksToBounds = false
        searchedContentView.layer.shadowPath = UIBezierPath(roundedRect: searchedContentView.bounds, cornerRadius: searchedContentView.layer.cornerRadius).cgPath
    }

}
