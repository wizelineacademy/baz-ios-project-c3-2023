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
}
