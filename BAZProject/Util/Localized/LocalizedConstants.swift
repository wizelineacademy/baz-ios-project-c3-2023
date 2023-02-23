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
    static let commonSubTitleFont: UIFont = UIFont(name: "AppleSDGothicNeo-Bold", size: 16) ?? UIFont()
    static let commonLayerShadowOffset: CGSize = CGSize(width: 0, height: 1)
    static let commonLayerShadowOpacity: Float = 0.3
    static let commonLayerCornerRadius: CGFloat = 10
    static let commonAnimationDuration: CGFloat = 1.5
    static let commonRotationAnimationDuration: CGFloat = 1.0
    static let commonRotationToValue: NSNumber = NSNumber(value: Double.pi * 2)
    static let commonToValueAnimation: CGFloat = 1.0
    static let commonPulseAnimationFromValue: CGFloat = 0.7
    static let commonScaleAnimationFromValue: CGFloat = 0.95
    static let commonTagView: Int = 2104082
    static let commonDarkGrayColor: UIColor = .init(red: 214, green: 215, blue: 217)
    static let commonLightGrayColor: UIColor = .init(red: 241, green: 243, blue: 242)
    static let commonLayerStartPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)
    static let commonLayerEndPoint: CGPoint = CGPoint(x: 0.0, y: 1.0)
    static let commonGradientLayerLocations: [NSNumber] = [0.0, 0.5, 1.0]
    static let commonAnimationTimeInterval: CFTimeInterval = 0.9
    static let commonAnimationFromValue: [Float] = [-1.0, -0.5, 0.0]
    static let commonAnimationToValue: [Float] = [1.0, 1.5, 2.0]
    static let commonSkeletonTransparency: CGFloat = 0.5
    static let commonVelocity: CFTimeInterval = 1
    static let commonIncrementNumber: Int = 1
    static let commonHeaderColor: UIColor = UIColor(named: "Header") ?? .systemBackground
    static let commonBackgroundColor: UIColor = UIColor(named: "BackGround") ?? .systemBackground
    static let commonPrimaryColor: UIColor = UIColor(named: "PrimaryColor") ?? .systemBackground
    static let commonSecondaryColor: UIColor = UIColor(named: "SecondaryColor") ?? .systemBackground
    static let commonHeightHeaderTable: CGFloat = 50
    static let commonSpacingIntoView: Int = 16
    static let commonSpacingIntoViewMedium: Int = Int(commonSpacingIntoView / 2)
    static let commonSizeIcon: Int = 30
    static let commonSpacingYUIAlert: Int = 25
    static let commonHeaderImageViewCGRect: CGRect = CGRect(x: commonSpacingIntoView,
                                                            y: 10,
                                                            width: commonSizeIcon,
                                                            height: commonSizeIcon)
    static let commonHeightHeader: Int = 40
    static let commonSpacingInY: Int = 5

    // MARK: - Notification Center
    static let notificationCenterNameShowDetail: String = "showDetail"
    static let notificationCenterNameParamId: String = "id"

    // MARK: - UIColor
    static let uiColorAlpha: Float = 1.0
    static let uiColorValueTotalRGB: CGFloat = 255

    // MARK: - LaunchScreen
    static let launchScreenDivisorNumer: CGFloat = 4.0

    // TODO: remove this
    static let launchScreenAnimationDuration: Double = 0 //1.5

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
    static let infiniteScrollActivityViewDivisorNumber: CGFloat = 2
    static let infiniteScrollActivityViewSpaceTop: CGFloat = 30

    // MARK: - Trending
    static let trendingFirstSubview: Int = 0

    // MARK: - ImageSlider
    static let imageSliderTimeInterval: Double = 2.0
    static let imageSliderInitCurrentPageSlider: Int = 0
    static let imageSliderMinimunSpacingForSection: Double = 0.0
    static let imageSliderIncrementShowImage: Int = 1
    static let imageSliderNumberSections: Int = 0
    static let imageSliderValueDefaultX: CGFloat = 0.0

    // MARK: - StarRated
    static let starRatedInitSection: Int = 0
}
