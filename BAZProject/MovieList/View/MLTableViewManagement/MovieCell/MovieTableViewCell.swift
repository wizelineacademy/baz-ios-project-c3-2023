//
//  MovieTableViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 30/01/23.
//

import UIKit

final class MovieTableViewCell: UITableViewCell {
    
    static let nib: UINib = UINib(nibName: String(describing: MovieTableViewCell.self), bundle: .main)
    static let identifier: String = "MovieCell"
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieSeenCounter: UILabel!
    
    /**
     Configures the cell apearance with the received object
     - Parameters:
        - movie: a Movie object 
     */
    func setupCell(with movie: Movie) {
        title.text = movie.title
        releaseDate.text = "Lazamiento: \(movie.releaseDate ?? "")"
        language.text = "Idioma original: \(movie.originalLanguage)"
        movieSeenCounter.isHidden = movie.movieSeenCount == nil
        movieSeenCounter.text = movie.timesSeen
        posterImage.image = UIImage(named: "poster")
        
        guard let url = movie.getPosterURL(size: .medium) else { return }
        ImageCache.shared.getImage(from: url) { [weak self] result in
            switch result {
            case .success(let imaage):
                self?.posterImage.image = imaage
            case .failure(_):
                break
            }
        }
    }
}
