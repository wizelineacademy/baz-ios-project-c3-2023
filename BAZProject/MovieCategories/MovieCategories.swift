//
//  MovieCategories.swift
//  BAZProject
//
//  Created by Luis Alberto Perez Villar on 07/02/23.
//

import UIKit

final class MovieCategories {
    
    /**
     Returns a tab bar controller with a list of view controllers, each of them with a different movie category and one more with a movie seaker view controller
     */
    static func createMoviesTabBarController() -> UIViewController {
        let movieCategories = UITabBarController()
        movieCategories.setViewControllers(self.getViewControllers(), animated: false)
        
        return movieCategories
    }
    
    /**
     Returns an array of view controllers, each of them with a different movie category and one more with a movie seaker view controller
     */
    private static func getViewControllers() -> [UIViewController] {
        let categories: [MovieCategory] = MovieCategory.allCases
        
        var providers: [MLProviderProtocol] = categories.map({ MovieProvider(category: $0) })
        providers.insert(StoredMoviesProvider(), at: 2)
        var viewControllers: [UIViewController] = providers.map { provider in
            let viewController = MLRouter.getEntry(with: provider)
            let tabBarItem = UITabBarItem(
                title: provider.viewTitle,
                image: UIImage(systemName: provider.iconName),
                selectedImage: nil
            )
            viewController.tabBarItem = tabBarItem
            return UINavigationController(rootViewController: viewController)
        }
        
        let provider = MovieSearchProvider()
        let searchView = UINavigationController(rootViewController: MSRouter.getEntry(with: provider))
        searchView.tabBarItem.title = "Buscar"
        searchView.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewControllers.insert(searchView, at: 2)
        
        return viewControllers
    }
}
