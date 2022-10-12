//
//  NetworkManagerTests.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/10/12.
//

import XCTest
@testable import iOS_malrangBookFinder

final class NetworkManagerTests: XCTestCase {
    private var sut: Networkable!
    private let mockDataManager = MockDataTestManager()

    override func setUpWithError() throws {
        let session = self.mockDataManager.makeMockUrlSession()
        self.sut = NetworkManager(urlSession: session)
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_request호출시_httpResponse의_statusCode가_200일때_GoogleBooksSampleData의_데이터를_가져오는지() {
        // given
        let promise = expectation(description: "totalItems 1355와 일치하는지")
        self.mockDataManager.makeRequestSuccessResult()
        let endPoint = Endpoint(host: "test")

        // when
        _ = self.sut.request(endPoint: endPoint)
            .decode(type: SearchResultDTO.self, decoder: Json.decoder)
            .subscribe { bookList in
                let result = bookList.totalItems
                let expected = 1355
                XCTAssertEqual(expected, result)
                promise.fulfill()
            } onError: { _ in
                XCTFail()
                promise.fulfill()
            }
        wait(for: [promise], timeout: 10)
    }

    func test_request호출시_httpResponse의_statusCode가_400일때_statusCodeError에러를_반환하는지() {
        // given
        let promise = expectation(description: "totalItems 1355와 일치하는지")
        self.mockDataManager.makeRequestFailureResult()
        let endPoint = Endpoint(host: "test")

        // when
        _ = self.sut.request(endPoint: endPoint)
            .decode(type: SearchResultDTO.self, decoder: Json.decoder)
            .subscribe { _ in
                XCTFail()
                promise.fulfill()
            } onError: { error in
                let result = error as! NetworkError
                let expected = NetworkError.statusCodeError(statusCode: 400)
                XCTAssertEqual(expected, result)
                promise.fulfill()
            }
        wait(for: [promise], timeout: 10)
    }
}
