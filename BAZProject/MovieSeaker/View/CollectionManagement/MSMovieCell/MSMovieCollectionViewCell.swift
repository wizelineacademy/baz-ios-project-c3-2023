//
//  MSMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

final class MSMovieCollectionViewCell: UICollectionViewCell {

    static let nib: UINib = UINib(nibName: String(describing: MSMovieCollectionViewCell.self), bundle: .main)
    static let identifier: String = "MovieCollectionCell"
    static let minimumSpace: CGFloat = 12
    static var sizeForRow: CGSize = .zero
    
    @IBOutlet weak var movieImage: UIImageView!

    /**
     Set the cell appearance with the received Movie object
     - Parameters:
        - movie: a Movie object
     */
    func setupCell(with movie: Movie) {
        self.movieImage.image = UIImage(named: "poster")
        guard let imageURL = movie.getPosterURL(size: .medium) else { return }
        ImageCache.shared.getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                self?.movieImage.image = image
            case .failure(_):
                break
            }
        }
    }
    
    /**
     Set a standar size for item
     - Parameters:
        - itemsForRow: an integer tha define the number of items per row in the collection view
     */
    static func setSizeForItem(itemsForRow: Int) {
        let bounds = UIScreen.main.bounds
        let itemsForRow: CGFloat = CGFloat(integerLiteral: itemsForRow)
        let spaces = itemsForRow + 1
        let width = (bounds.width - (minimumSpace * spaces)) / itemsForRow
        let height = width * 4.5 / 3
        sizeForRow = CGSize(width: width, height: height)
    }
}
