//
//  RepositoryTests.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/10/12.
//

import XCTest
@testable import iOS_malrangBookFinder

import RxSwift

final class RepositoryTests: XCTestCase {
    private let mockDataManager = MockDataTestManager()
    private var sut: GoogleBooksRepositoryProtocol!
    private var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSession = mockDataManager.makeMockUrlSession()
        let networkManager = NetworkManager(urlSession: urlSession)
        self.sut = GoogleBooksRepository(networkManger: networkManager)
        self.disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
        self.disposeBag = nil
    }

    func test_searchBookList호출시_성공한_경우_SearchResultDTO의_totalItems가_1355인지() {
        // given
        let promise = expectation(description: "totalItems가 1355인지")
        self.mockDataManager.makeRequestSuccessResult()

        // when
        self.sut.searchBookList(text: "test", startIndex: 0, maxResult: 20)
            .subscribe(onNext: { searchResult in
                //then
                let result = searchResult.totalItems
                let expected = 1355
                XCTAssertEqual(expected, result)
                promise.fulfill()
            }, onError: { _ in
                XCTFail()
            })
            .disposed(by: self.disposeBag)
        wait(for: [promise], timeout: 5)
    }

    func test_searchBookList호출시_실패한_경우_에러를_전달하는지() {
        // given
        let promise = expectation(description: "에러가 전달되는지")
        self.mockDataManager.makeRequestFailureResult()

        // when
        self.sut.searchBookList(text: "test", startIndex: 0, maxResult: 20)
            .subscribe(onNext: { _ in
                XCTFail()
            }, onError: { _ in
                XCTAssertTrue(true)
                promise.fulfill()
            })
            .disposed(by: self.disposeBag)
        wait(for: [promise], timeout: 5)
    }
}
