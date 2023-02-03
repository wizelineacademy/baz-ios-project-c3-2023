//
//  UIViewController+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 01/02/23.
//

import UIKit

enum UIImageType {
    case systemName
    case named
}

extension UIViewController {
    
    func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
    
    func getUIImage(for name: String, type: UIImageType) -> UIImage {
        var uiImage: UIImage?
        switch type {
        case .systemName:
            uiImage = UIImage(systemName: name)
        case .named:
            uiImage = UIImage(named: name)
        }
        return uiImage ?? UIImage()
    }
}
