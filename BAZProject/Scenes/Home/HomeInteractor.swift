//
//  HomeInteractor.swift
//  BAZProject
//
//  Created by 1034209 on 01/02/23.
//

import Foundation
import UIKit

protocol HomeBusinessLogic: AnyObject {
    
}

protocol HomeDataStore {
}

class HomeInteractor: HomeBusinessLogic {
    
    // MARK: Properties VIP
    var presenter: HomePresentationLogic?
}

