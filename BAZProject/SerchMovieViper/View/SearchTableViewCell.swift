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
            self.searchedContentView.addShadow()
        }
    }
}
