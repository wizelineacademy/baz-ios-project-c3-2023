//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let nib: UINib = UINib(nibName: "MovieTableViewCell", bundle: .main)
    static let identifier: String = "MovieCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    
}
