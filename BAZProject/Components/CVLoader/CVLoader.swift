//
//  CVLoader.swift
//  BAZProject
//
//  Created by Cristian Eduardo Villegas Alvarez on 18/04/23.
//

import Foundation
import UIKit

class CVLoader {
    private static var loadingView: UIView?

    class func startLoading() {
        guard let topViewController = UIApplication.shared.windows.first?.rootViewController?.topMostViewController() else {
            return
        }
        let loadingView = UIView(frame: topViewController.view.bounds)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = loadingView.center
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)        
        topViewController.view.addSubview(loadingView)
        self.loadingView = loadingView
    }
    
    class func stopLoading() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presentedViewController = presentedViewController {
            return presentedViewController.topMostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topMostViewController() ?? self
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topMostViewController() ?? self
        }
        return self
    }
    func removeAllKeyboards() {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        else { return }
        window.rootViewController?.view.endEditing(true)
    }
}
