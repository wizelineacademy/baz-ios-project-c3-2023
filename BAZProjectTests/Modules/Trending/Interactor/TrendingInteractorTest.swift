//
//  TrendingInteractorTest.swift
//  BAZProjectTests
//
//  Created by 1058889 on 07/02/23.
//

@testable import BAZProject
import XCTest

class TrendingInteractorTests: XCTestCase {
    
    private var sut: TrendingInteractor?
    var dataManagerMock: TrendingDataManagerMock?
    override func setUp() {
        super.setUp()
        self.sut = TrendingInteractor()
        self.dataManagerMock = TrendingDataManagerMock()
        self.sut?.dataManager = self.dataManagerMock
    }
    
    override func tearDown() {
        self.sut = nil
        self.dataManagerMock = nil
        super.tearDown()
    }
    
    func test_getTrendingMedia_callDataManagerToGetData() {
        sut?.getTrendingMedia(mediaType: .all, timeWindow: .week)
        XCTAssertEqual(dataManagerMock?.calls, [.requestTrendingMedia])
    }
}
