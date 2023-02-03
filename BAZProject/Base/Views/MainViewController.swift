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
    
    fileprivate func setStyleView() {
        view.backgroundColor = .systemBackground
        tabBar.barTintColor = .systemBackground
        tabBar.tintColor = .red
        tabBar.layer.shadowRadius = LocalizedConstants.mainShadowRadius
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = LocalizedConstants.mainShadowOpacity
    }
    
    fileprivate func setTabBarStyle() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .red
        tabBar.barTintColor = .red
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    private func initializeViewControllers() {
        var arrControllers:[UIViewController] = []
        arrControllers.append(createNavController(for: TrendingViewRouter.createModule(),
                                                  title: .mainTitleView,
                                                  image: getUIImage(for: .mainNameIconTabBar, type: .systemName)))
        viewControllers = arrControllers
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for:.selected)
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        
        rootViewController.navigationItem.searchController = getUISearchController()
        rootViewController.navigationItem.title = title
        
        return navController
    }
    
    private func getUISearchController() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = .mainPlaceholderSearchBar
        navigationItem.searchController = searchController
        definesPresentationContext = true
        return searchController
    }
}

extension MainViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let textSearching = searchController.searchBar.text else { return }
        print("Searching with: " + (textSearching))
    }
}
