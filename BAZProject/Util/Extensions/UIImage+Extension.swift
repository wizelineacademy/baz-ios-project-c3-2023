//
//  UIImage+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

extension UIImageView {

    func loadImage(id: String) {
    
        let cache: NSCache = NSCache<NSString, UIImage>()

        self.addSkeletonAnimation()
        image = UIImage()
        let defaultImage = UIImage(named: LocalizedConstants.uiImageNameDefaultImage)
        let strUrl: String = id
        if let img = cache.object(forKey: NSString(string: strUrl)) {
            self.removeSkeletonAnimation()
            image = img
            return
        }
        
        guard let url = URL(string: strUrl) else {
            self.removeSkeletonAnimation()
            image = defaultImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if error != nil {
                self?.removeSkeletonAnimation()
                self?.image = defaultImage
            } else {
                self?.guaranteeMainThread {
                    self?.removeSkeletonAnimation()
                    guard let data = data,
                          let tempImg = UIImage(data: data) else { return }
                    self?.alpha = LocalizedConstants.uiImageAlpha
                    self?.image = tempImg
                    UIView.animate(withDuration: LocalizedConstants.uiImageAnimateDuration) {
                        self?.alpha = LocalizedConstants.uiImageAlphaOnAnimate
                    }
                    cache.setObject(tempImg, forKey: NSString(string: strUrl))
                }
            }
        }.resume()
    }
    
    private func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
