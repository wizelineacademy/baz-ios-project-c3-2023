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
    
    var presenter: ErrorPagePresenterProtocol?
    var errorType: ErrorType?
    
    static let nibName: String = "ErrorPageView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reintent(_ sender: Any) {
        presenter?.closeThisInstance()
    }
}

