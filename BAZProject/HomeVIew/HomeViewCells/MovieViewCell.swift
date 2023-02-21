//
//  TableViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 16/02/23.
//

import UIKit

final class MovieViewCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    /// This method recive a  parameter of type `Movie` to fill the cell info
    ///  - Parameters:
    ///  - for: is the info for the movie of type `Movie`
    func setInfo(for movie:Movie){
        imageMovie.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        titleMovie.text = movie.title
    }
    
}
