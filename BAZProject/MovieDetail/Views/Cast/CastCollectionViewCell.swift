//
//  CastCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 22/02/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblRealName: UILabel!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var imgCast: UIImageView! {
        didSet{
            imgCast.layer.cornerRadius = imgCast.frame.width / 2
        }
    }
    //MARK: - Properties
    static var identifier = "CastCollectionViewCell"
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with model: Cast ) {
        lblRealName.text = model.originalName
        lblMovieName.text = model.character
        if model.profilePath == nil {
            self.imgCast.image = UIImage(named: "poster")
        }else{
            if let url = URL(string: model.fullProfilePath) {
                getData(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    DispatchQueue.main.async {
                        self.imgCast.image = UIImage(data: data)
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
