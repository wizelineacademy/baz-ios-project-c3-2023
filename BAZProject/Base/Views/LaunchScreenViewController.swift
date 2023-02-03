//
//  LaunchScreenViewController.swift
//  BAZProject
//
//  Created by 1058889 on 29/01/23.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var logoUIImageView: UIImageView! {
        didSet {
            logoUIImageView.layer.cornerRadius = logoUIImageView.bounds.height / LocalizedConstants.launchScreenDivisorNumer
            logoUIImageView.rotate()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimationLoader()
    }
    
    fileprivate func addAnimationLoader() {
        UIView.transition(with: logoUIImageView,
                          duration: LocalizedConstants.launchScreenAnimationDuration,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
            self?.logoUIImageView.image = UIImage()
        },
                          completion: { [weak self] _ in
            let mainVC: UITabBarController = MainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self?.present(mainVC, animated: true)
        })
    }
}
