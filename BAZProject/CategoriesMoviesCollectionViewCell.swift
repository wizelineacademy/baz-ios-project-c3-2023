//
//  CategoriesMoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import UIKit

class CategoriesMoviesCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var degradeImageview: UIImageView!
    @IBOutlet weak var categoriesMovieTitleLabel: UILabel!
    
    override func prepareForReuse() {
        self.categoriesImageView.image = UIImage(named: "poster")
    }
    
    func setupCategoryImage(for image: UIImage){
        DispatchQueue.main.async {
            self.categoriesImageView.clipsToBounds = true
            self.categoriesImageView.layer.cornerRadius = 8.0
            self.degradeImageview.clipsToBounds = true
            self.degradeImageview.layer.cornerRadius = 8.0
            self.categoriesImageView.image = image
        }
    }
    
    func setupCategoryTitle(indexPath: Int){
        switch indexPath{
        case 0:
            self.categoriesMovieTitleLabel.text = "Trending"
        case 1:
            self.categoriesMovieTitleLabel.text = "Now Playing"
        case 2:
            self.categoriesMovieTitleLabel.text = "Popular"
        case 3:
            self.categoriesMovieTitleLabel.text = "Top rated"
        case 4:
            self.categoriesMovieTitleLabel.text = "Upcoming"
        default:
            self.categoriesMovieTitleLabel.text = ""
        }
    }
}
