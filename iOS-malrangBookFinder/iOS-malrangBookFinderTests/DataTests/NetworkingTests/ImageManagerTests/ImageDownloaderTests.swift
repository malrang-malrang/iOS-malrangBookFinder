//
//  ImageDownloaderTests.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/11/12.
//

import XCTest
@testable import iOS_malrangBookFinder

final class ImageDownloaderTests: XCTestCase {
    private let mockDataManager = MockDataTestManager()
    private var sut: ImageDownloadable!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let urlSession = self.mockDataManager.makeMockUrlSession()
        self.sut = ImageDownloader(session: urlSession)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        self.sut = nil
    }

        func test_downloadImage호출시_httpResponse의_statusCode가_200일때_데이터가_전달되는지() {
            // given
            let promise = expectation(description: "failure에 에러가 전달되는지")
            self.mockDataManager.makeSuccessDataResult()

            // when
            self.sut.downloadImage(with: "test") { result in
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

    func test_downloadImage호출시_httpResponse의_statusCode가_400일때_에러를_전달하는지() {
        // given
        let promise = expectation(description: "failure에 에러가 전달되는지")
        self.mockDataManager.makeFailureResult()

        // when
        self.sut.downloadImage(with: "test") { result in
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
