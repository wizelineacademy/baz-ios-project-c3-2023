//
//  LaunchScreenViewController.swift
//  BAZProject
//
//  Created by 1058889 on 29/01/23.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var logoUIImageView: UIImageView! {
        didSet {
            logoUIImageView.layer.cornerRadius = logoUIImageView.bounds.height / 4
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logoUIImageView.rotate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.transition(with: self.logoUIImageView,
                                  duration: 3.0,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.logoUIImageView.image = UIImage(systemName: "home")
        }) { _ in
            let mainVC = MainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true)
        }
    }
}
