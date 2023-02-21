//
//  ImageManage.swift
//  BAZProject
//
//  Created by 1050210 on 20/02/23.
//

import UIKit

extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true
    self.image = anyImage
  }
}
