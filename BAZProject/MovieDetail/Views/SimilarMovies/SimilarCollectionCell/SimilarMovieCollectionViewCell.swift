//
//  SimilarMovieCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 22/02/23.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    
    //MARK: - Properties
    static let identifier = "SimilarMovieCollectionViewCell"

    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        self.imgMoviePoster.image = UIImage()
        self.lblMovieName.text = ""
    }
    
    public func configure(withModel model : SimilarMovie) {
        self.lblMovieName.text = model.title
        if model.posterPath == nil {
            self.imgMoviePoster.image = UIImage(named: "poster")
        }else{
            if let url = URL(string: model.fullPosterPath) {
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
