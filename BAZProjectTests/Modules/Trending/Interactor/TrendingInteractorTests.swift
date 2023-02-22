//
//  TrendingInteractorTests.swift
//  BAZProjectTests
//
//  Created by 1058889 on 07/02/23.
//

@testable import BAZProject
import XCTest

class TrendingInteractorTests: XCTestCase {
    private var sut: TrendingInteractor?
    private var presenterMock: TrendingPresenterMocks?

    var dataManagerMock: TrendingDataManagerMocks?
    override func setUp() {
        super.setUp()
        self.sut = TrendingInteractor()
        self.presenterMock = TrendingPresenterMocks()
        self.dataManagerMock = TrendingDataManagerMocks()
        self.sut?.dataManager = self.dataManagerMock
        self.sut?.presenter = self.presenterMock
    }

    override func tearDown() {
        self.sut = nil
        self.presenterMock = nil
        self.dataManagerMock = nil
        super.tearDown()
    }

    func test_getTrendingMedia_callDataManagerToGetData() {
        sut?.fetchTrendingMedia(mediaType: .all, timeWindow: .week)
        XCTAssertEqual(dataManagerMock?.calls, [.requestTrendingMedia])
    }

    func test_getTrendingMedia_buildUrlToService() {
        sut?.fetchTrendingMedia(mediaType: .all, timeWindow: .week)
        XCTAssertEqual(dataManagerMock?.calls, [.requestTrendingMedia])
    }

    func test_handleGetTrendingMedia_callGetTrendingMedia() {
        sut?.handleGetTrendingMedia(getMovieResult())
        XCTAssertEqual(presenterMock?.calls, [.getTrendingMedia])
        XCTAssertEqual(presenterMock?.capturedResult?.first?.adult, getMovieResult().first?.adult)
        XCTAssertEqual(presenterMock?.capturedResult?.first?.title, getMovieResult().first?.title)
    }

    // MARK: Helper
    func getMovieResult() -> [MovieResult] {
        return [MovieResult(adult: true,
                           backdropPath: "",
                           id: 1,
                           title: "title",
                           originalLanguage: nil,
                           originalTitle: nil,
                           overview: nil,
                           posterPath: nil,
                           mediaType: nil,
                           genreIDS: nil,
                           popularity: nil,
                           releaseDate: nil,
                           video: nil,
                           voteAverage: nil,
                           voteCount: nil)]
    }
}
