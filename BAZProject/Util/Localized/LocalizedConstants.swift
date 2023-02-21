//
//  LocalizedConstants.swift
//  BAZProject
//
//  Created by 1058889 on 02/02/23.
//

import UIKit

enum LocalizedConstants {
    
    // MARK: - Common
    static let commonTitleFont: UIFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 20) ?? UIFont()
    static let commonLayerShadowOffset: CGSize = CGSize(width: 0, height: 1)
    static let commonLayerShadowOpacity: Float = 0.3
    static let commonLayerCornerRadius: CGFloat = 10

    // MARK: - LaunchScreen
    static let launchScreenDivisorNumer: CGFloat = 4.0
    static let launchScreenAnimationDuration: Double = 1.5
    
    // MARK: - Main
    static let mainShadowRadius: CGFloat = 4
    static let mainShadowOpacity: Float = 0.15
    
    // MARK: - UIImage
    static let uiImageNameDefaultImage: String = "poster"
    static let uiImageAnimateDuration: Double = 1.5
    static let uiImageAlpha: Double = 0.2
    static let uiImageAlphaOnAnimate: Double = 1.0
    
    // MARK: - CellMovie
    static let cellMovieDivisorNumberHeight: CGFloat = 2
    
    // MARK: - InfiniteScrollActivityView
    static let infiniteScrollActivityViewDefaultHeight: CGFloat = 60.0
    static let infiniteScrollActivityViewDivisorNumberHeightAndWidth: CGFloat = 2
    static let infiniteScrollActivityViewSpaceTop: CGFloat = 30
    
    // MARK: - Trending
    static let trendingFirstSubview: Int = 0
    
    // MARK: - ImageSlider
    static let imageSliderTimeInterval: Double = 2.0
    static let imageSliderInitCurrentPageSlider: Int = 0
    static let imageSliderMinimunSpacingForSection: Double = 0.0
    static let imageSliderIncrementShowImage: Int = 1
    static let imageSliderNumberSections: Int = 0
    static let imageSliderScrollViewContentOffsetDefaultX: CGFloat = 0.0
}
