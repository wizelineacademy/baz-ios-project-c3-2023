//
//  TrendingPresenterMocks.swift
//  BAZProjectTests
//
//  Created by 1058889 on 07/02/23.
//

@testable import BAZProject

enum TrendingPresenterCall {
    case getTrendingMedia
}

final class TrendingPresenterMocks {
    var router: BAZProject.TrendingRouterProtocol?
    var view: BAZProject.TrendingViewProtocol?
    var interactor: BAZProject.TrendingInteractorInputProtocol?
    var calls: [TrendingPresenterCall] = []
    var capturedResult: [MovieResult]?
}

extension TrendingPresenterMocks: TrendingPresenterProtocol {
    func getTrendingMedia(mediaType: BAZProject.MediaType, timeWindow: BAZProject.TimeWindowType) {
    }
}

extension TrendingPresenterMocks: TrendingInteractorOutputProtocol {
    func getTrendingMedia(result: [BAZProject.MovieResult]) {
        calls.append(.getTrendingMedia)
        self.capturedResult = result
    }

    func showViewError(_ error: Error) { }
}
