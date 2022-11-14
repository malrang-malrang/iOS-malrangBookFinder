//
//  NetworkManagerTests.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/10/12.
//

import XCTest
@testable import iOS_malrangBookFinder

import RxSwift

final class NetworkManagerTests: XCTestCase {
    private let mockDataManager = MockDataTestManager()
    private var sut: Networkable!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSession = self.mockDataManager.makeMockUrlSession()
        self.sut = NetworkManager(urlSession: urlSession)
        self.disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
        self.disposeBag = nil
    }

    func test_request호출시_httpResponse의_statusCode가_200일때_데이터가_전달되는지() {
        // given
        let promise = expectation(description: "subscribe에 값이 전달되는지")
        self.mockDataManager.makeSuccessDataResult()
        let endPoint = Endpoint(host: "test")

        // when
        self.sut.request(endPoint: endPoint)
            .subscribe(onNext: { _ in
                //then
                XCTAssertTrue(true)
                promise.fulfill()
            }, onError: { _ in
                XCTFail()
            })
            .disposed(by: self.disposeBag)
        wait(for: [promise], timeout: 5)
    }

    func test_request호출시_httpResponse의_statusCode가_400일때_에러를_전달하는지() {
        // given
        let promise = expectation(description: "onError에 에러가 전달되는지")
        self.mockDataManager.makeFailureResult()
        let endPoint = Endpoint(host: "test")

        // when
        self.sut.request(endPoint: endPoint)
            .subscribe(onNext: { _ in
                XCTFail()
            }, onError: { _ in
                //then
                XCTAssertTrue(true)
                promise.fulfill()
            })
            .disposed(by: self.disposeBag)
        wait(for: [promise], timeout: 5)
    }
}
