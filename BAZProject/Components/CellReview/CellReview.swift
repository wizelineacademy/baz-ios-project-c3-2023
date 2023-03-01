//  CellReview.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CellReviewDelegate: AnyObject {
    func showMore()
}

final class CellReview: UITableViewCell {
    static let  identifier: String = .cellReviewXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var titleLabel: UILabel! {
        didSet {
            titleLabel.addShadow(LocalizedConstants.commonSecondaryColor)
        }
    }
    @IBOutlet weak private var showMoreButton: UIButton! {
        didSet {
            showMoreButton.setTitle(.cellReviewTitleShowMore, for: .normal)
        }
    }
    @IBOutlet weak private var descriptionConstraintBottom: NSLayoutConstraint!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var rateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = LocalizedConstants.cellReviewNumberLines
        }
    }
    @IBOutlet weak private var photoImageView: UIImageView! {
        didSet {
            photoImageView.addRounding()
        }
    }

    var delegate: CellReviewDelegate?

    // MARK: - Private properties
    private var showMore: Bool = false {
        didSet {
            descriptionLabel.numberOfLines = showMore ? .zero : LocalizedConstants.cellReviewNumberLines
            let titleButton: String = showMore ? .cellReviewTitleHide : .cellReviewTitleShowMore
            showMoreButton.setTitle(titleButton, for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(with reviewType: ReviewType) {
        titleLabel.text = reviewType.title
        if !reviewType.urlPhoto.isEmpty {
            let photoUrlString: String = Endpoint.img(idImage: reviewType.urlPhoto, sizeImage: .w500).urlString
            photoImageView.loadImage(id: photoUrlString)
        }
        rateLabel.text = reviewType.rate.description
        dateLabel.text = "\(String.cellReviewWriteOn) \(reviewType.date.getDateFormatted())"
        descriptionLabel.text = reviewType.content
        calculateConstraintButtonBottom()
    }

    func setNumberLineInZero() {
        showMore = true
    }

    func hideButtonShowMore() {
        showMoreButton.isHidden = true
    }

    // MARK: - Private methods
    @IBAction private func showMoreAction(_ sender: Any) {
        showMore.toggle()
        delegate?.showMore()
    }

    private func calculateConstraintButtonBottom() {
        if descriptionLabel.countLines() > LocalizedConstants.cellReviewNumberLines {
            descriptionConstraintBottom.constant = LocalizedConstants.cellReviewConstraintBottom
        } else {
            showMoreButton.isHidden = true
        }
    }
}
