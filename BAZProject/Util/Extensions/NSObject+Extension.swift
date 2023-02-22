//  NSObject+Extension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 21/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension NSObject {
    func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }

    func getSectionHeaderForTableView(titleString: String,
                                      width: Int,
                                      backgroundColor: UIColor = LocalizedConstants.commonHeaderColor,
                                      colorTitle: UIColor = .brown
    ) -> UIView {
        let sectionHeaderLabelView: UIView = UIView()
        sectionHeaderLabelView.backgroundColor = backgroundColor

        let sectionHeaderImage: UIImage = #imageLiteral(resourceName: "logo")
        let sectionHeaderImageView: UIImageView = UIImageView(image: sectionHeaderImage)
        sectionHeaderImageView.frame = LocalizedConstants.commonHeaderImageViewCGRect
        sectionHeaderLabelView.addSubview(sectionHeaderImageView)

        let sectionHeaderLabel: UILabel = UILabel()
        sectionHeaderLabel.text = titleString
        sectionHeaderLabel.textColor = colorTitle
        sectionHeaderLabel.font = LocalizedConstants.commonTitleFont
        let xImagePosition: Int = LocalizedConstants.commonSpacingIntoView + LocalizedConstants.commonSizeIcon +
            LocalizedConstants.commonSpacingIntoViewMedium
        sectionHeaderLabel.frame = CGRect(x: xImagePosition,
                                          y: LocalizedConstants.commonSpacingInY,
                                          width: width,
                                          height: LocalizedConstants.commonHeightHeader)
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)
        return sectionHeaderLabelView
    }
}
