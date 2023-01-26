//
//  TrendingViewPresenter.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

typealias presenterProtocols = TrendingPresenterProtocol & TrendingViewInteractorOutputProtocol
class TrendingViewPresenter: presenterProtocols {
    
    var router: TrendingRouterProtocol?
    var view: TrendingViewProtocol?
    var interactor: TrendingViewInteractorInputProtocol?
}
