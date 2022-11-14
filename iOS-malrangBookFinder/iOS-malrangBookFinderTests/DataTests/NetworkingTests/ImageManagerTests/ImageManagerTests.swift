//
//  ImageManagerTests.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/11/12.
//

import XCTest
@testable import iOS_malrangBookFinder

final class ImageManagerTests: XCTestCase {
    private let mockDataManager = MockDataTestManager()
    private var sut: ImageManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSession = self.mockDataManager.makeMockUrlSession()
        let downloader = ImageDownloader(session: urlSession)
        self.sut = ImageManager(downloader: downloader)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

    func test_downloadImage호출시_성공한_경우_UIImage가_전달되는지() {
        // given
        let promise = expectation(description: "failure에 에러가 전달되는지")
        self.mockDataManager.makeSuccessImageResult()

        // when
        self.sut.retriveImage(with: "test") { result in
            switch result {
            case .success(_):
                //then
                XCTAssertTrue(true)
                promise.fulfill()
            case .failure(_):
                XCTFail()
            }
        }
        wait(for: [promise], timeout: 5)
    }

    func test_downloadImage호출시_실패한_경우_에러를_전달하는지() {
        // given
        let promise = expectation(description: "failure에 에러가 전달되는지")
        self.mockDataManager.makeFailureResult()

        // when
        self.sut.retriveImage(with: "test") { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                //then
                XCTAssertTrue(true)
                promise.fulfill()
            }
        }
        wait(for: [promise], timeout: 5)
    }
}
