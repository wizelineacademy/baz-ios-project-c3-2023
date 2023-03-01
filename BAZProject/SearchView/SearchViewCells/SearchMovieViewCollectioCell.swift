//
//  SearchMovieViewCollectioCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 17/02/23.
//

import UIKit

final class SearchMovieViewCollectioCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        moviePosterImage.image = nil
        titleMovie.text = nil
    }
    /// This method recive a  parameter of type `Movie` to fill the cell info
    ///  - Parameters:
    ///  - for: is the info for the movie of type `Movie`
    func setInfo(for movie: Movie){
        moviePosterImage.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        titleMovie.text = movie.title
    }
}
