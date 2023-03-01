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
