//
//  UIImageExtension.swift
//  BAZProject
//
//  Created by 1014600 on 16/02/23.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /**
     A function that download an image in a UIImageView.
     - Parameters:
        - urlStr: The url of the remote image
     */
    func loadImage(urlStr: String) {
        image = UIImage()
        if let img = imageCache.object(forKey: NSString(string: urlStr)) {
            image = img
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print(err)
            } else {
                DispatchQueue.main.async {
                    guard let data = data, let tempImg = UIImage(data: data) else { return }

                    self.alpha = 0.3;
                    self.image = tempImg

                    UIView.animate(withDuration: 1.5) {
                        self.alpha = 1.0;
                    }
                    imageCache.setObject(tempImg, forKey: NSString(string: urlStr))
                }
            }
        }.resume()
    }
}
