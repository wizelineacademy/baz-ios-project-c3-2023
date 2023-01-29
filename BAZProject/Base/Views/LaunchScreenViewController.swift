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
            logoUIImageView.rotate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimationLoader()
    }
    
    fileprivate func addAnimationLoader() {
        UIView.transition(with: logoUIImageView,
                                  duration: 2.0,
                                  options: .transitionCrossDissolve,
                                  animations: { [weak self] in
            self?.logoUIImageView.image = UIImage()
        }) { [weak self] _ in
            let mainVC = MainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self?.present(mainVC, animated: true)
        }
    }
}
