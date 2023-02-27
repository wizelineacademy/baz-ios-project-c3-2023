//  CellReview.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 24/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CellReview: UITableViewCell {
    static let  identifier: String = .cellReviewXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet weak private var titleLabel: UILabel! {
        didSet {
            titleLabel.addShadow(LocalizedConstants.commonSecondaryColor)
        }
    }
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var rateLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel! {
        didSet {
            self.descriptionLabel.isUserInteractionEnabled = true
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel))
            self.descriptionLabel.addGestureRecognizer(tapgesture)
            self.descriptionLabel.numberOfLines = 3
        }
    }

    @IBOutlet weak private var photoImageView: UIImageView! {
        didSet {
            photoImageView.addRounding()
        }
    }
    //MARK:- tappedOnLabel
        @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
            guard let text = self.descriptionLabel.text else { return }
            let privacyPolicyRange = (text as NSString).range(of: "privacy policy")
            let termsAndConditionRange = (text as NSString).range(of: "terms and condition")
            if gesture.didTapAttributedTextInLabel(label: self.descriptionLabel, inRange: privacyPolicyRange) {
                print("user tapped on privacy policy text")
            } else if gesture.didTapAttributedTextInLabel(label: self.descriptionLabel, inRange: termsAndConditionRange){
                print("user tapped on terms and conditions text")
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(title: String, urlPhoto: String, rate: Double, date: String, content: String) {
        titleLabel.text = title
        photoImageView.loadImage(id: Endpoint.img(idImage: urlPhoto, sizeImage: .w500).urlString)
        rateLabel.text = rate.description
        dateLabel.text = "Escrito el \(date.getDateFormatted())"
        descriptionLabel.text = content
        if descriptionLabel.countLines() > 3 {

        }
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
            locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}

extension UILabel {
  func countLines() -> Int {
    guard let myText = self.text as NSString? else {
      return 0
    }
    // Call self.layoutIfNeeded() if your view uses auto layout
    let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
    return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
  }
}
