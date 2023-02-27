//
//  MainTabRouter.swift
//  BAZProject
//
//  Created by 1029187 on 08/02/23.
//

import UIKit

class MainTabBarRouter {
    
    class func createMainTabBarModule() -> UITabBarController {
        let mainTabBar = UITabBarController()
        let trendingView = TrendingRouter.createTrendingModule()
        let topRatedView = TopRatedRouter.createTopRatedModule()
        let searchingViewController = SearchingRouter.createSearchingModule()
        mainTabBar.viewControllers = [trendingView, topRatedView, searchingViewController]
        MainTabBarRouter.addMoviesShownObserver()
        return mainTabBar
    }
    
    static func addMoviesShownObserver() {
        let notificationName = Notification.Name("movieDetailShown")
        NotificationCenter.default.addObserver(self, selector: #selector(incrementMoviesShown), name: notificationName, object: nil)
    }
    
    @objc static func incrementMoviesShown() {
        var moviesShownCounter: Int = UserDefaults.standard.value(forKey: "moviesShownCounter") as? Int ?? 0
            moviesShownCounter += 1
            UserDefaults.standard.set(moviesShownCounter, forKey: "moviesShownCounter")
            print("Movies shown: \(moviesShownCounter)")
    }
}
