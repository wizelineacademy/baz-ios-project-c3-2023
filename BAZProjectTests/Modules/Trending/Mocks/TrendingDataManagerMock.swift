//
//  TrendingDataManagerMock.swift
//  BAZProjectTests
//
//  Created by 1058889 on 07/02/23.
//

@testable import BAZProject

enum TrendingDataManagerCall {
    case requestTrendingMedia
}

final class TrendingDataManagerMock: TrendingDataManagerInputProtocol {
    var interactor: BAZProject.TrendingDataManagerOutputProtocol?
    var calls: [TrendingDataManagerCall] = []
    
    func requestTrendingMedia(_ urlString: String) {
        calls.append(.requestTrendingMedia)
    }
}
