//
//  TrendingDataManagerMocks.swift
//  BAZProjectTests
//
//  Created by 1058889 on 07/02/23.
//

@testable import BAZProject

enum TrendingDataManagerCall {
    case requestTrendingMedia
    case handleGetTrendingMedia
}

final class TrendingDataManagerMocks {
    var interactor: BAZProject.TrendingDataManagerOutputProtocol?
    var calls: [TrendingDataManagerCall] = []
}

extension TrendingDataManagerMocks: TrendingDataManagerInputProtocol {
    func requestTrendingMedia(_ urlString: String) {
        calls.append(.requestTrendingMedia)
    }

    func handleGetTrendingMedia(_ result: [MovieResult]) {
        calls.append(.handleGetTrendingMedia)
    }

    func handleErrorService(_ error: Error) {
    }
}
