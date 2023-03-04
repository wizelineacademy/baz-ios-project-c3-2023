//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 15/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var imgMoviePoster: UIImageView!
    @IBOutlet var lblMovieTitle: UILabel!
    
    //MARK: - Properties
    static let identifier = "MovieCollectionViewCell"
    
    //MARK: - Functions
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgMoviePoster.layer.cornerRadius = 5.0
    }
    
    override func prepareForReuse() {
        self.imgMoviePoster.image = UIImage()
        self.lblMovieTitle.text = ""
    }
    
    public func configure(withModel model : Movie) {
        self.lblMovieTitle.text = model.title
        if model.posterPath == nil {
            self.imgMoviePoster.image = UIImage(named: "poster")
        } else {
            if let url = URL(string: model.posterImagefullPath) {
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        self.imgMoviePoster.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
