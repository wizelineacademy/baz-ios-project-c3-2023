//
//  ErrorPageViewController.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

final class ErrorPageViewController: UIViewController, ErrorPageViewProtocol {

    @IBOutlet weak private var imgErrorLogo: UIImageView! {
        didSet {
            if let icon = UIImage(named: .nameIcon404) {
                imgErrorLogo.image = icon
            }
        }
    }

    @IBOutlet weak private var retryButton: UIButton! {
        didSet {
            retryButton.setTitle(.retryTitleButton, for: .normal)
        }
    }

    @IBOutlet weak private var principalTitleLabel: UILabel! {
        didSet {
            principalTitleLabel.text = .errorPagePrincipalTitleLabel
        }
    }

    @IBOutlet weak private var titleErrorLabel: UILabel!
    @IBOutlet weak private var descriptionErrorLabel: UILabel!

    static let identifier: String = .errorPageXibIdentifier
    var presenter: ErrorPagePresenterProtocol?
    var errorType: ErrorType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    @IBAction private func retry(_ sender: Any) {
        presenter?.closeThisInstance()
    }

    // MARK: - Private methods
    private func configView() {
        hideBackItem()
        if let errorType = errorType {
            titleErrorLabel.text = errorType.title
            descriptionErrorLabel.text = errorType.message
            title = errorType.titleNavBar ?? ""
        }
    }

    private func hideBackItem() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }
}
