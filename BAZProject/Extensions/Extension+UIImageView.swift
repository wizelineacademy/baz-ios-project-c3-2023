//
//  Extension+UIImage.swift
//  BAZProject
//
//  Created by nsanchezj on 03/02/23.
//

import Foundation
import UIKit

extension UIImageView {
    /**
     obtains image loaded from url path
     - Parameter url: url path obtained from model Movie
     */
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
