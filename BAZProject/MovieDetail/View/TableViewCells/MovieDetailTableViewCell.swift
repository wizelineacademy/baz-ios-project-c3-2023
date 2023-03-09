//
//  MovieDetailTableViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class MovieDetailTableViewCell: UITableViewCell {
    
    static var nib: UINib = UINib(nibName: String(describing: MovieDetailTableViewCell.self), bundle: .main)
    static var identifier: String = String(describing: MovieDetailTableViewCell.self)

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
}

extension MovieDetailTableViewCell: GenericTableViewCell {
    
    /**
     Configure the complete cell with the received model
     - Parameters:
        - model: a GenericRow object
     */
    func setupCell(with model: GenericTableViewRow) {
        self.selectionStyle = .none
        guard let movie = model as? Movie else { return }
        self.title.text = movie.title
        self.releaseDate.text = movie.releaseDate
        self.movieDescription.text = movie.overview
        self.movieImage.image = UIImage(named: "poster")
        
        guard let imageURL = movie.getBackgroundMovieURL(size: .huge) else { return }
        ImageCache.shared.getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.movieImage.image = image
            default:
                break
            }
        }
    }
}
