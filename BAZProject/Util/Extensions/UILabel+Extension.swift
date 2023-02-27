//  UILabel+Extension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 26/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UILabel {
    func countLines() -> Int {
        guard let myText = self.text as NSString? else { return .zero }
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: self.font as Any],
                                            context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
}
