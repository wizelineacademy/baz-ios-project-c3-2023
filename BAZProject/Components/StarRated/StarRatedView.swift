//  StarRatedView.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// This class allows you to create a qualified star view.
///
/// :conditions: The methods it has are those declared in the class 'StarRatedView':
/// * func setData
///
final class StarRatedView: CustomView {
    static let identifier: String = .starRatedXibIdentifier

    /// This function allows to get the UINib of the cell.
    /// Way to call StarRatedView.nib()
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override var nameXIB: String { .starRatedXibIdentifier }

    // MARK: - Declaration IBOutlets
    @IBOutlet weak private var starsStackContainer: UIStackView!

    // MARK: - Private properties
    private var selectedRate: Int = LocalizedConstants.starRatedInitSection
    private var numberStars: Int = LocalizedConstants.starRatedInitSection

    /// This function allows you to configure the view, where you must indicate the selectedRate parameter and optionally numberStars.
    ///
    /// :param: selectedRate Int indicating the number of stars selected
    ///         numberStars Int indicating the number of stars to draw (optional parameter)
    func setData(selectedRate: Int, numberStars: Int = LocalizedConstants.starRatedNumberStars) {
        self.numberStars = numberStars
        self.selectedRate = selectedRate
        guaranteeMainThread {
            self.setupView()
        }
    }

    // MARK: - Private method
    private func setupView() {
        addGestureRecognizer()
        if numberStars >= selectedRate {
            createStars()
        }
        drawStarsSelected()
    }

    private func drawStarsSelected() {
        if selectedRate != .zero {
            changeStateStarRate()
        }
    }

    /// This function allows add stars images in container fron star number to the limit stars.
    private func createStars() {
        for index in LocalizedConstants.starRatedInitSection...numberStars {
            let star = makeStarIcon()
            star.tag = index
            starsStackContainer.addArrangedSubview(star)
        }
    }

    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        starsStackContainer.addGestureRecognizer(tapGesture)
    }

    /// This function allows get an UIImageView with a star image.
    private func makeStarIcon() -> UIImageView {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "icon_unfilled_star"), highlightedImage: #imageLiteral(resourceName: "icon_filled_star"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }

    @objc private func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starsStackContainer)
        let starWidth = starsStackContainer.bounds.width / CGFloat(numberStars)
        let rate = Int(location.x / starWidth) + LocalizedConstants.commonIncrementNumber

        if rate != self.selectedRate {
            self.selectedRate = rate
        }
        changeStateStarRate()
    }

    private func changeStateStarRate() {
        starsStackContainer.arrangedSubviews.forEach { subview in
            guard let starImageView = subview as? UIImageView else {
                return
            }
            starImageView.isHighlighted = starImageView.tag <= selectedRate
        }
    }
}
