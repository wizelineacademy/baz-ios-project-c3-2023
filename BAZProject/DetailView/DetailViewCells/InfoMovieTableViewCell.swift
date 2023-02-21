//
//  InfoMovieTableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

final class InfoMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var backDropImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// This method recive a  parameter of type `Movie` to fill the cell info
    ///  - Parameters:
    ///  - for: is the info for the movie of type `Movie`
    func setInfo(for movie:Movie){
        backDropImage.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.backdropPath ?? "")")
        titleMovie.text = movie.title
        descriptionMovie.text = movie.overview
    }
}
