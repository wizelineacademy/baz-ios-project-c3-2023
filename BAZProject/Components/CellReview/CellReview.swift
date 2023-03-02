//  CellReview.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// This delegate allows you to delegate the function of showing more of the cell.
///
/// :conditions: The methods it has are those declared in the delegate 'CellReviewDelegate':
/// func showMore()
///
protocol CellReviewDelegate: AnyObject {
    func showMore()
}

final class CellReview: UITableViewCell {
    static let  identifier: String = .cellReviewXibIdentifier

    /// This function allows to get the UINib of the cell.
    /// Way to call CellReview.nib()
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    // MARK: - Declaration IBOutlets
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

    weak var delegate: CellReviewDelegate?

    // MARK: - Private properties
    private var showMore: Bool = false {
        didSet {
            configView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(with reviewType: ReviewType) {
        setUpCell(with: reviewType)
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

    /// This method adds a space between the button show more and the label description
    private func calculateConstraintButtonBottom() {
        if descriptionLabel.countLines() > LocalizedConstants.cellReviewNumberLines {
            descriptionConstraintBottom.constant = LocalizedConstants.cellReviewConstraintBottom
        } else {
            showMoreButton.isHidden = true
        }
    }

    private func setUpCell(with reviewType: ReviewType) {
        titleLabel.text = reviewType.title
        if !reviewType.urlPhoto.isEmpty {
            setupPhotoImageView(with: reviewType.urlPhoto)
        }
        rateLabel.text = reviewType.rate.description
        dateLabel.text = "\(String.cellReviewWriteOn) \(reviewType.date.getDateFormatted())"
        descriptionLabel.text = reviewType.content
    }

    private func setupPhotoImageView(with imageUrlString: String) {
        let photoUrlString: String = Endpoint.img(idImage: imageUrlString, sizeImage: .w500).urlString
        photoImageView.loadImage(id: photoUrlString)
    }

     /// This function allows to configure the cell to show or not the 'show more' button
     /// and to configure the size of the description.
    private func configView() {
        descriptionLabel.numberOfLines = showMore ? .zero : LocalizedConstants.cellReviewNumberLines
        let titleButton: String = showMore ? .cellReviewTitleHide : .cellReviewTitleShowMore
        showMoreButton.setTitle(titleButton, for: .normal)
    }
}
