//  UITableView+Extension.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 27/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: reloadData) { _ in
            completion()
        }
    }
}
