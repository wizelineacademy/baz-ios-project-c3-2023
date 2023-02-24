//
//  CategoriesMoviesCollectionViewCell.swift
//  BAZProject
//
//  Created by 1050210 on 30/01/23.
//

import UIKit

protocol CategoriesMoviesCellDelegate: AnyObject {
    var currentlySelected: CategoriesMoviesCollectionViewCell? { get set }
    func didSelectCell(indexPath : IndexPath, cell: CategoriesMoviesCollectionViewCell)
}

class CategoriesMoviesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoriesImageView: UIImageView!
    @IBOutlet weak var degradeImageview: UIImageView!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var categoriesMovieTitleLabel: UILabel!
    weak var delegate: CategoriesMoviesCellDelegate?
    var indexPath: IndexPath?
    var indexPathRow: Int?
    
    
    
    override func prepareForReuse() {
        self.categoriesImageView.image = UIImage(named: "poster")
    }
    
    func setupCell(cellTitle: String, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.indexPathRow = indexPath.row
        self.setupCategoryTitle(cellTitle: cellTitle)
        categoriesView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setCellSelected)))
        if delegate?.currentlySelected == nil { setCellSelected() }
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
        self.degradeImageview.layer.borderColor = UIColor.systemBlue.cgColor
        self.degradeImageview.layer.borderWidth = 4.0
        delegate?.didSelectCell(indexPath: self.indexPath ?? IndexPath(), cell: self)
    }
    
    func setCellDeselected(){
        self.degradeImageview.layer.borderColor = nil
        self.degradeImageview.layer.borderWidth = 0.0
        self.categoriesMovieTitleLabel.textColor = .white
    }
}

