//
//  UIViewExtension.swift
//  BAZProject
//
//  Created by 1014600 on 22/02/23.
//

import UIKit

extension UIView {
    
    private func addGradientLayer(startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let darkGray: CGColor = UIColor(red: 214/255, green: 215/255, blue: 217/255, alpha: 1).cgColor
        let lightGray: CGColor = UIColor(red: 241/255, green: 243/255, blue: 242/255, alpha: 1).cgColor
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [darkGray, lightGray, darkGray]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        for subview in self.subviews where subview.tag == 2104082 {
            subview.layer.addSublayer(gradientLayer)
        }
        return gradientLayer
    }

    private func addAnimation(duration: CFTimeInterval = 0.9) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = duration
        return animation
    }
    
    func addSkeletonAnimation(transparency: CGFloat = 0.5, velocity: CFTimeInterval = 1, startPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)) {
        layer.masksToBounds = true
        let shimmerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(transparency)
        shimmerView.clipsToBounds = true
        shimmerView.tag = 2104082
        addSubview(shimmerView)
        let gradientLayer = addGradientLayer(startPoint: startPoint, endPoint: endPoint)
        let animation = addAnimation(duration: velocity)
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func removeSkeletonAnimation() {
        for subview in self.subviews where subview.tag == 2104082 {
            subview.removeFromSuperview()
            subview.layer.mask = nil
        }
    }
}
