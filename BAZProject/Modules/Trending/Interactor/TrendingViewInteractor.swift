//
//  TrendingViewInteractor.swift
//  BAZProject
//
//  Created by 1058889 on 26/01/23.
//

import Foundation

typealias TrendingInteractorProtocol = TrendingViewInteractorInputProtocol & TrendingViewInteractorOutputProtocol
class TrendingViewInteractor: TrendingInteractorProtocol {
    var presenter: TrendingViewInteractorOutputProtocol?
    var providerNetworking: NetworkingProviderProtocol?
}
