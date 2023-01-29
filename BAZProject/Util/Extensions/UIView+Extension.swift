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
        self.addSubview(loader)
    }

    func removeLoader() {
        if let loader = subviews.first(where: { $0 is Loader }) {
            loader.removeFromSuperview()
        }
    }

    func rotate() {
            let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = NSNumber(value: Double.pi * 2)
            rotation.duration = 1
            rotation.isCumulative = true
            rotation.repeatCount = Float.greatestFiniteMagnitude
            layer.add(rotation, forKey: "rotationAnimation")
        }
}
