//
//  EmptyMoviesCollectionCell.swift
//  BAZProject
//
//  Created by 1014600 on 23/02/23.
//

import UIKit

class EmptyMoviesCollectionCell: UICollectionViewCell {

    static var cellIdentifier: String = "EmptyCollectionCell"

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        label.backgroundColor = .white
        label.text = "Sin resultados"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(){
        addSubview(nameLabel)

        nameLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true
    }
}
