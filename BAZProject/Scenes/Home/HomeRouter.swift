//
//  HomeRouter.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation

@objc protocol HomeRoutingLogic {
    // TODO: create functions to manage routing logic
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeRoutingLogic, HomeDataPassing {
    
    // MARK: Properties
    var dataStore: HomeDataStore?
    weak var viewController: HomeViewController?
    
    // TODO: conform HomePresenter protocol
}
