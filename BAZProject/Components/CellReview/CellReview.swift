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
            self.titleLabel.isUserInteractionEnabled = true
            let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel))
            self.titleLabel.addGestureRecognizer(tapgesture)
        }
    }
    @IBOutlet weak private var photoImageView: UIImageView! {
        didSet {
            photoImageView.addRounding()
        }
    }
    //MARK:- tappedOnLabel
        @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
            guard let text = self.titleLabel.text else { return }
            let privacyPolicyRange = (text as NSString).range(of: "privacy policy")
            let termsAndConditionRange = (text as NSString).range(of: "terms and condition")
            if gesture.didTapAttributedTextInLabel(label: self.titleLabel, inRange: privacyPolicyRange) {
                print("user tapped on privacy policy text")
            } else if gesture.didTapAttributedTextInLabel(label: self.titleLabel, inRange: termsAndConditionRange){
                print("user tapped on terms and conditions text")
            }
        }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(title: String, urlPhoto: String) {
        titleLabel.text = "privacy policy asdad terms and condition"
        photoImageView.loadImage(id: Endpoint.img(idImage: urlPhoto, sizeImage: .w500).urlString)
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
