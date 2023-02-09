//
//  Extension+UITableView.swift
//  BAZProject
//
//  Created by nsanchezj on 07/02/23.
//

import Foundation
import UIKit

extension UITableView {
    /**
     obtains class for register tableview cell
     - Parameter classBundle: class for register tableview cell
     */
    func getBundleAndRegisterCell(_ classBundle: AnyClass) {
        self.register(UINib.init(nibName: String(describing: classBundle.self), bundle: Bundle(for: classBundle.self)), forCellReuseIdentifier: String(describing: classBundle.self))
    }
}
