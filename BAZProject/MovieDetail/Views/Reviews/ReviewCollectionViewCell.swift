//
//  ReviewCollectionViewCell.swift
//  BAZProject
//
//  Created by hlechuga on 23/02/23.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblCreatedBy: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblReview: UILabel!
    
    //MARK: - Parameters
    static let identifier = "ReviewCollectionViewCell"
    
    //MARK: - Functions
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with model:Review) {
        let dateCreatedAt = getDateFormated(from: model.createdAt ?? "")
        lblCreatedBy.text = "Creado por \(model.author ?? "") el \(dateCreatedAt)"
        lblReview.text = model.content
    }

    private func getDateFormated(from stringDate: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd/MM/yy"
        let date = dateFormater.date(from: stringDate) ?? Date()
        return dateFormater.string(from: date)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBackground.layer.borderWidth = 1.0
        viewBackground.layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        viewBackground.layer.cornerRadius = 5.0
    }

}
