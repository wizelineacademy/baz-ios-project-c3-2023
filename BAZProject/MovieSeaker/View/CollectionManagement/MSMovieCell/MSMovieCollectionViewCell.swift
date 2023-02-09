//
//  MSMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/02/23.
//

import UIKit

class MSMovieCollectionViewCell: UICollectionViewCell {

    static let nib: UINib = UINib(nibName: String(describing: MSMovieCollectionViewCell.self), bundle: .main)
    static let identifier: String = "MovieCollectionCell"
    static let minimumSpace: CGFloat = 12
    static var sizeForRow: CGSize = .zero
    
    @IBOutlet weak var movieImage: UIImageView!

    func setCell(with movie: Movie) {
        self.movieImage.image = UIImage(named: "poster")
        if let imageURL = movie.getPosterURL(size: .medium) {
            let task = URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, _) in
                DispatchQueue.main.async {
                    if let data = data {
                        self?.movieImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
    
    static func setSizeForRow(items: Int) {
        let bounds = UIScreen.main.bounds
        let itemsForRow: CGFloat = CGFloat(integerLiteral: items)
        let spaces = itemsForRow + 1
        let width = (bounds.width - (minimumSpace * spaces)) / itemsForRow
        let height = width * 4.5 / 3
        sizeForRow = CGSize(width: width, height: height)
    }
}
