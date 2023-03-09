//
//  ReviewCollectionViewCell.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 08/03/23.
//

import UIKit

final class ReviewCollectionViewCell: UICollectionViewCell {

    static var nib: UINib = UINib(nibName: String(describing: ReviewCollectionViewCell.self), bundle: .main)
    static var identifier: String = String(describing: ReviewCollectionViewCell.self)

    @IBOutlet private weak var avatar: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = contentView.frame.height / 2
    }
    
}

extension ReviewCollectionViewCell: GenericCollectionViewCell {
    
    /// Configures cell properties with the given data
    /// - Parameter model: a GenericCollectionViewRow object
    func setupCell(with model: GenericCollectionViewRow) {
        guard let review = model as? Review else { return }
        self.name.text = review.reviewer.name
        self.userName.text = review.reviewer.userName
        self.avatar.image = UIImage(named: "poster")
        
        guard let url = review.reviewer.getImageURL() else { return }
        ImageCache.shared.getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.avatar.image = image
            case .failure(_):
                break
            }
        }
    }
}
