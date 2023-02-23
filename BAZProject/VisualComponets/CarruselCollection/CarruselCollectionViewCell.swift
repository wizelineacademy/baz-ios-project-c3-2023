//
//  CarruselCollectionCell.swift
//  BAZProject
//
//  Created by 1034209 on 09/02/23.
//

import Foundation
import UIKit

class CarruselCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "CarruselCollectionViewCell"
    
    lazy var imageView: UIImageView? = {
        let view = UIImageView(frame: bounds)
        view.image = UIImage(named: "poster")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var labelTitle: UILabel? = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = UIImage(named: "poster")
    }
    
    private func configureView() {
        guard let imageView = imageView, let labelTitle = labelTitle else {
            return
        }
        addSubview(imageView)
        addSubview(labelTitle)

        leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        
        leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: labelTitle.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: labelTitle.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: labelTitle.bottomAnchor).isActive = true
        
        bringSubviewToFront(imageView)
    }
}
