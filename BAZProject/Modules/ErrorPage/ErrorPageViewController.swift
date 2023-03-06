//
//  ErrorPageViewController.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

protocol ErrorPageViewProtocol {
    func reintent()
}

class ErrorPageViewController: CustomView {
    override var nameXIB: String {"ErrorPageView"}

    @IBOutlet weak var imgErrorLogo: UIImageView! {
        didSet {
            if let icon = UIImage(named: .nameIcon404) {
                imgErrorLogo.image = icon
            }
        }
    }

    weak var delegate: ErrorPageViewProtocol?

    @IBAction func reintent(_ sender: Any) {
        delegate?.reintent()
    }
}
