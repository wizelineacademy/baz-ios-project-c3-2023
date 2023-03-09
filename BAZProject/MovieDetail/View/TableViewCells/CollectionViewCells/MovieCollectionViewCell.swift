//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    static var nib: UINib = UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: .main)
    static var identifier: String = String(describing: MovieCollectionViewCell.self)

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var title: UILabel!
    
}

extension MovieCollectionViewCell: GenericCollectionViewCell {
    
    /// Configures cell properties with the given data
    /// - Parameter model: a GenericCollectionViewRow object
    func setupCell(with model: GenericCollectionViewRow) {
        guard let movie = model as? Movie else { return }
        self.title.text = movie.title
        self.movieImage.image = UIImage(named: "poster")
        
        guard let url = movie.getPosterURL() else { return }
        ImageCache.shared.getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.movieImage.image = image
            case .failure(_):
                break
            }
        }
    }
}
