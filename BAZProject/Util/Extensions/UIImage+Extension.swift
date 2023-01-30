//
//  UIImage+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

let cache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImage(id: String) {
        
        image = UIImage()
        let defaultImage = UIImage(named: "poster")
        let strUrl = id
        if let img = cache.object(forKey: NSString(string: strUrl)) {
            image = img
            return
        }
        
        guard let url = URL(string: strUrl) else {
            image = defaultImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let _ = error {
                self?.image = defaultImage
            } else {
                DispatchQueue.main.async {
                    guard let data = data,
                          let tempImg = UIImage(data: data) else { return }
                    self?.alpha = 0.2;
                    self?.image = tempImg
                    UIView.animate(withDuration: 1.5) {
                        self?.alpha = 1.0;
                    }
                    cache.setObject(tempImg, forKey: NSString(string: strUrl))
                }
            }
        }.resume()
    }
}
