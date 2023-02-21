//  StarRatedView.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 19/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class StarRatedView: CustomView {
    static let identifier: String = .starRatedXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override var nameXIB: String { .starRatedXibIdentifier }
    
    @IBOutlet weak private var starsStackContainer: UIStackView!
    
    // MARK: - Private properties
    private var selectedRate: Int = LocalizedConstants.starRatedInitSection
    private var numberStars: Int = LocalizedConstants.starRatedInitSection

    func setData(numberStars: Int, selectedRate: Int) {
        guaranteeMainThread {
            self.setupView()
            self.numberStars = numberStars
            self.selectedRate = selectedRate
            if numberStars >= selectedRate {
                self.createStars()
            }
            if selectedRate != 0 {
                self.changeStateStarRate()
            }
        }
    }

    // MARK: - Private method
    private func createStars() {
        for index in LocalizedConstants.starRatedInitSection...numberStars {
            let star = makeStarIcon()
            star.tag = index
            starsStackContainer.addArrangedSubview(star)
        }
    }
    
    private func setupView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        starsStackContainer.addGestureRecognizer(tapGesture)
    }
    
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
