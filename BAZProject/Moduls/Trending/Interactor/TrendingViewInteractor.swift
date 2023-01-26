//
//  TrendingViewInteractor.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

typealias trendingInteractorProtocol = TrendingViewInteractorInputProtocol & TrendingViewInteractorOutputProtocol
class TrendingViewInteractor: trendingInteractorProtocol {
    var presenter: TrendingViewInteractorOutputProtocol?
    var providerNetworking: NetworkingProviderProtocol?
}
