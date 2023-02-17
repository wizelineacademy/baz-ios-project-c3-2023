//
//  SearchMovieViewCollectioCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 17/02/23.
//

import UIKit

class SearchMovieViewCollectioCell: UICollectionViewCell {

    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setInfo(for movie: Movie){
        moviePosterImage.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")
        titleMovie.text = movie.title
    }
}
