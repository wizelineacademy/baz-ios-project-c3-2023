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

    // MARK: - LaunchScreen
    static let launchScreenDivisorNumer: CGFloat = 4.0
    static let launchScreenAnimationDuration: Double = 2.0
    
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
    static let cellMovieLayerShadowOpacity: Float = 0.3
    static let cellMovieLayerCornerRadius: CGFloat = 10
    static let cellMovieLayerShadowOffset: CGSize = CGSize(width: 0, height: 1)
    
    // MARK: - InfiniteScrollActivityView
    static let infiniteScrollActivityViewDefaultHeight: CGFloat = 60.0
    static let infiniteScrollActivityViewDivisorNumberHeightAndWidth: CGFloat = 2
    static let infiniteScrollActivityViewSpaceTop: CGFloat = 30
    
    // MARK: - Trending
    static let trendingFirstSubview: Int = 0
}