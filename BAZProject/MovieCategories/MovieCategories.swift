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
        
        let providers: [MLProviderProtocol] = categories.map({ MovieProvider(category: $0) })
        var viewControllers = providers.map { provider in
            let viewController = MLRouter.getEntry(with: provider)
            let tabBarItem = UITabBarItem(
                title: provider.viewTitle,
                image: UIImage(systemName: provider.iconName),
                selectedImage: nil
            )
            viewController.tabBarItem = tabBarItem
            return UINavigationController(rootViewController: viewController)
        }
        
        let provider = MSProvider()
        let seakerView = UINavigationController(rootViewController: MSRouter.getEntry(with: provider))
        seakerView.tabBarItem.title = "Buscar"
        seakerView.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewControllers.insert(seakerView, at: 3)
        
        return viewControllers
    }
}
