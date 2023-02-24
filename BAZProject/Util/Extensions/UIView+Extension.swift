//
//  UIView+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

extension UIView {
    func showLoader() {
        let loader = Loader(frame: frame)
        addSubview(loader)
    }

    func removeLoader() {
        if let loader = subviews.first(where: { $0 is Loader }) {
            loader.removeFromSuperview()
        }
    }

    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = LocalizedConstants.commonRotationToValue
        rotation.duration = LocalizedConstants.commonRotationAnimationDuration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: "rotationAnimation")
    }

    func addSkeletonAnimation(transparency: CGFloat = LocalizedConstants.commonSkeletonTransparency,
                              velocity: CFTimeInterval = LocalizedConstants.commonVelocity,
                              startPoint: CGPoint = LocalizedConstants.commonLayerStartPoint,
                              endPoint: CGPoint = LocalizedConstants.commonLayerEndPoint) {
        layer.masksToBounds = true
        let shimmerView = UIView(frame: CGRect(x: .zero,
                                               y: .zero,
                                               width: self.frame.size.width,
                                               height: self.frame.size.height))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(transparency)
        shimmerView.clipsToBounds = true
        shimmerView.tag = LocalizedConstants.commonTagView
        addSubview(shimmerView)
        let gradientLayer = addGradientLayer(startPoint: startPoint, endPoint: endPoint)
        let animation = addAnimation(duration: velocity)
        gradientLayer.add(animation, forKey: animation.keyPath)
    }

    func removeSkeletonAnimation() {
        guaranteeMainThread {
            for subview in self.subviews where subview.tag == LocalizedConstants.commonTagView {
                subview.removeFromSuperview()
                subview.layer.mask = nil
            }
        }
    }

    func addShadow(_ color: UIColor = .black) {
        self.layer.shadowOffset = LocalizedConstants.commonLayerShadowOffset
        self.layer.shadowOpacity = LocalizedConstants.commonLayerShadowOpacity
        self.layer.cornerRadius = LocalizedConstants.commonLayerCornerRadius
        self.layer.shadowColor = color.cgColor
    }

    func addPulsationAnimation() {
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = LocalizedConstants.commonAnimationDuration
        pulseAnimation.fromValue = LocalizedConstants.commonPulseAnimationFromValue
        pulseAnimation.toValue = LocalizedConstants.commonToValueAnimation
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(pulseAnimation, forKey: nil)

        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.duration = LocalizedConstants.commonAnimationDuration
        scaleAnimation.fromValue = LocalizedConstants.commonScaleAnimationFromValue
        scaleAnimation.toValue = LocalizedConstants.commonToValueAnimation
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .greatestFiniteMagnitude
        self.layer.add(scaleAnimation, forKey: nil)
    }

    // MARK: - Private methods
    private func addGradientLayer(startPoint: CGPoint = LocalizedConstants.commonLayerStartPoint,
                                  endPoint: CGPoint = LocalizedConstants.commonLayerEndPoint) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let darkGray: CGColor = LocalizedConstants.commonDarkGrayColor.cgColor
        let lightGray: CGColor = LocalizedConstants.commonLightGrayColor.cgColor
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [darkGray, lightGray, darkGray]
        gradientLayer.locations = LocalizedConstants.commonGradientLayerLocations
        for subview in self.subviews where subview.tag == LocalizedConstants.commonTagView {
            subview.layer.addSublayer(gradientLayer)
        }
        return gradientLayer
    }

    private func addAnimation( duration: CFTimeInterval = LocalizedConstants.commonAnimationTimeInterval
    ) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = LocalizedConstants.commonAnimationFromValue
        animation.toValue = LocalizedConstants.commonAnimationToValue
        animation.repeatCount = .infinity
        animation.duration = duration
        return animation
    }
}
