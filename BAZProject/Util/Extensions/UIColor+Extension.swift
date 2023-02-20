//  UIColor+Extension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 20/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// Converting numbers to UIColor
    ///
    /// - Parameter red: input value red Float
    /// - Parameter green: input value green Float
    /// - Parameter blue: input value blue Float
    /// - Parameter alpha: input value alpha Float
    convenience init(red: Float, green: Float, blue: Float, alpha: Float = LocalizedConstants.uiColorAlpha) {
        self.init(red: CGFloat(red) / LocalizedConstants.uiColorValueTotalRGB,
                  green: CGFloat(green) / LocalizedConstants.uiColorValueTotalRGB,
                  blue: CGFloat(blue) / LocalizedConstants.uiColorValueTotalRGB,
                  alpha: CGFloat(alpha) / LocalizedConstants.uiColorValueTotalRGB)
    }
}
