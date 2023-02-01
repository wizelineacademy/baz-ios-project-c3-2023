//
//  UIViewController+Extension.swift
//  BAZProject
//
//  Created by 1058889 on 01/02/23.
//

import UIKit

extension UIViewController {
    
    func guaranteeMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }

}
