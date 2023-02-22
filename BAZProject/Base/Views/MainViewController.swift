//
//  MainViewController.swift
//  BAZProject
//
//  Created by 1058889 on 28/01/23.
//

import UIKit

final class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleView()
        initializeViewControllers()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTabBarStyle()
    }

    // MARK: - Private methods
    fileprivate func setStyleView() {
        view.backgroundColor = LocalizedConstants.commonBackgroundColor
        tabBar.barTintColor = LocalizedConstants.commonBackgroundColor
        tabBar.tintColor = .white
        tabBar.layer.shadowRadius = LocalizedConstants.mainShadowRadius
        tabBar.layer.shadowColor = UIColor.white.cgColor
        tabBar.layer.shadowOpacity = LocalizedConstants.mainShadowOpacity
    }

    fileprivate func setTabBarStyle() {
        tabBar.backgroundColor = LocalizedConstants.commonHeaderColor
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }

    private func initializeViewControllers() {
        var arrControllers: [UIViewController] = []
        arrControllers.append(createNavController(for: HomeRouter.createModule(),
                                                  title: .homeTitle,
                                                  image: getUIImage(for: .homeNameIconTabBar, type: .systemName)))
        arrControllers.append(createNavController(for: TrendingRouter.createModule(),
                                                  title: .trendingTitle,
                                                  image: getUIImage(for: .trendingNameIconTabBar, type: .systemName)))
        viewControllers = arrControllers
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white],
                                                         for: .selected)
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.prefersLargeTitles = true

        rootViewController.navigationItem.searchController = getUISearchController()
        rootViewController.navigationItem.title = title
        return navController
    }
}
