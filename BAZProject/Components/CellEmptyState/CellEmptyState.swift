//  CellEmptyState.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 28/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class CellEmptyState: UITableViewCell {
    static let  identifier: String = .cellEmptyStateXibIdentifier
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet private var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(message: String) {
        guaranteeMainThread {
            self.messageLabel.text = message
        }
    }
}
