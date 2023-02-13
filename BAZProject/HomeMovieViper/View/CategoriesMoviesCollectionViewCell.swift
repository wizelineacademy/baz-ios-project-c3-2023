//
//  CategoriesMoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import UIKit

protocol CategoriesMoviesCellDelegate: AnyObject {
    func didSelectCell(indexPath : Int, cell: CategoriesMoviesCollectionViewCell)
}

class CategoriesMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var degradeImageview: UIImageView!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var categoriesMovieTitleLabel: UILabel!
    weak var delegate: CategoriesMoviesCellDelegate?
    var indexPath : Int = 0
    
    
    
    override func prepareForReuse() {
        self.categoriesImageView.image = UIImage(named: "poster")
    }
    
    func setupCell(cellTitle: String, indexPath: Int) {
        self.indexPath = indexPath
        self.setupCategoryTitle(cellTitle: cellTitle)
        categoriesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setCellSelected)))
    }
    
    func setupCategoryImage(for image: UIImage?) {
        DispatchQueue.main.async {
            self.categoriesImageView.clipsToBounds = true
            self.categoriesImageView.layer.cornerRadius = 8.0
            self.degradeImageview.clipsToBounds = true
            self.degradeImageview.layer.cornerRadius = 8.0
            if let image = image{
                self.categoriesImageView.image = image
            } else {
                self.categoriesImageView.image = UIImage(named: "poster")
            }
        }
    }
    
    private func setupCategoryTitle(cellTitle: String) {
        self.categoriesMovieTitleLabel.text = cellTitle
    }
    
    @objc func setCellSelected() {
        self.categoriesMovieTitleLabel.textColor = .systemBlue
        delegate?.didSelectCell(indexPath: self.indexPath, cell: self)
    }
    
    func setCellDeselected(){
        self.categoriesMovieTitleLabel.textColor = .white
    }
}

