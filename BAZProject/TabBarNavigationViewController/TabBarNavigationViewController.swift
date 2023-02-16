//
//  TabBarNavigationViewController.swift
//  BAZProject
//
//  Created by nsanchezj on 16/02/23.
//

import UIKit

class TabBarNavigationViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
    }
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeMoviesViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: DetailsMovieViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
