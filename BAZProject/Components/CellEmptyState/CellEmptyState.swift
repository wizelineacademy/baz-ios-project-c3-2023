//  CellEmptyState.swift
//  BAZProject
//
//  Created by Gerardo Bautista Castañeda on 28/02/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// This class allows create an generic cell for an empty state.
/// Way of use: create a UIView and assign it the 'CellEmptyState' class.
/// Call the setData method to set the cell, example: 'setData(message: "404 - No data")'
///
/// :conditions: the available methods are:
/// * func setData(message: String)
/// * func nib()

class CellEmptyState: UITableViewCell {
    static let  identifier: String = .cellEmptyStateXibIdentifier

     /// This function allows to get the UINib of the cell.
     /// Way to call CellEmptyState.nib()
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBOutlet private var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    /// This function allows to configure the cell, indicating the 'message'.
    ///
    /// :param: message String indicating the name param message (example: setData(message: "404 - No data"))
    func setData(message: String) {
        guaranteeMainThread {
            self.messageLabel.text = message
        }
    }
}
