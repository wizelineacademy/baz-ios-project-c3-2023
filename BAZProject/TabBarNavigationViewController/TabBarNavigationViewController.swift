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
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.orange
    }
    
    /**
     set ViewControllers in TabBar for navigation in app
     */
    func setupVCs() {
        viewControllers = [
            createNavController(for: HomeMoviesViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: SearchMovieViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!)
        ]
    }
    
    /**
     set UI for TabBar
     - Parameter rootViewController: UIVC for navigation in TabBar
     - Parameter title: name option navigation TabBar
     - Parameter image: image for icon option navigation TabBar
     - Returns: UIViewController for navigation
     */
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
