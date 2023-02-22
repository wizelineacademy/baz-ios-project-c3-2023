//
//  DetailsTableViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 21/02/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    
    func setupCell(name: String, genres: String, overview: String){
        DispatchQueue.main.async {
            self.movieNameLabel.text = name
            self.movieGenresLabel.text = genres
            self.movieOverviewTextView.text = overview
        }
    }

}
