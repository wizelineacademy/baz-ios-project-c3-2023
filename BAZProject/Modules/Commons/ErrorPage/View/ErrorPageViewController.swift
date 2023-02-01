//
//  ErrorPageViewController.swift
//  BAZProject
//
//  Created by 1058889 on 24/01/23.
//

import UIKit

class ErrorPageViewController: UIViewController, ErrorPageViewProtocol {
    
    @IBOutlet weak var imgErrorLogo: UIImageView! {
        didSet {
            if let icon = UIImage(named: .nameIcon404) {
                imgErrorLogo.image = icon
            }
        }
    }
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var descriptionErrorLabel: UILabel!

    var presenter: ErrorPagePresenterProtocol?
    var errorType: ErrorType?
    var titleNavBar: String?
    
    static let nibName: String = "ErrorPageView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        hideBackItem()
        if let errorType = errorType {
            titleErrorLabel.text = errorType.title
            descriptionErrorLabel.text = errorType.message
        }
        
        if let titleNavBar = titleNavBar as? String {
            self.title = titleNavBar
        }
    }
    
    private func hideBackItem() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func reintent(_ sender: Any) {
        presenter?.closeThisInstance()
    }
}

