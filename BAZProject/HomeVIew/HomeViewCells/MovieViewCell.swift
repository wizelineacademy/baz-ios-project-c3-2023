//
//  TableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInfo(for movie:Movie){
        imageMovie.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        titleMovie.text = movie.title
    }
    
}
