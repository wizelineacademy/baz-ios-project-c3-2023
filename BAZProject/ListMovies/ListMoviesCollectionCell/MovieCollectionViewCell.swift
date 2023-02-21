//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgMoviePoster: UIImageView!
    @IBOutlet var lblMovieTitle: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        self.imgMoviePoster.image = UIImage()
        self.lblMovieTitle.text = ""
    }
    
    public func configure(withModel model : Movie) {
        self.lblMovieTitle.text = model.title
        if let url = URL(string: model.posterImagefullPath) {
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imgMoviePoster.image = UIImage(data: data)
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
