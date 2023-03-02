//
//  SearchingResultCollectionViewCell.swift
//  BAZProject
//
//  Created by 1029187 on 28/02/23.
//

import UIKit

class SearchingResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var resultModel: SearchResult? {
        didSet {
            self.configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func configure() {
        resultModel?.getImage(completion: { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movieTitle.text = self.resultModel?.title ?? ""
                self.movieImage.image = image
            }
        })
    }
}
