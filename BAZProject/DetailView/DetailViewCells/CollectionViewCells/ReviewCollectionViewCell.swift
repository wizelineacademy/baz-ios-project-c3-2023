//
//  ReviewCollectionViewCell.swift
//  BAZProject
//
//  Created by Jonathan Hernandez Ramos on 27/02/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var nameAuthor: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        avatarImage.layer.masksToBounds = true
        avatarImage.clipsToBounds = true
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        content.text = nil
        nameAuthor.text = nil
        avatarImage.image = nil
    }
    
    func setInfo(for review: Review){
        avatarImage.loadImage(urlString: "https://image.tmdb.org/t/p/w500\(review.authorDetails.avatarPath ?? "")")
        nameAuthor.text = review.author
        content.text = review.content
    }

}
