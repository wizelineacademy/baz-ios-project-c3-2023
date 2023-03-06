//
//  LaunchScreenViewController.swift
//  BAZProject
//
//  Created by 1058889 on 29/01/23.
//

import UIKit

final class LaunchScreenViewController: UIViewController {
    @IBOutlet weak private var logoUIImageView: UIImageView! {
        didSet {
            let cornerRadius: CGFloat = logoUIImageView.bounds.height / LocalizedConstants.launchScreenDivisorNumer
            logoUIImageView.layer.cornerRadius = cornerRadius
            logoUIImageView.rotate()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimationLoader()
    }

    // MARK: - Private methods
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
