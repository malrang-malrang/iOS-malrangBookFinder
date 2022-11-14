//
//  MockDataManager.swift
//  iOS-malrangBookFinderTests
//
//  Created by 김동욱 on 2022/10/12.
//

import UIKit

struct MockDataTestManager {
    func makeMockUrlSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]

        return URLSession(configuration: configuration)
    }

    func makeSuccessDataResult() {
        MockURLProtocol.requestHandler = { _ in
            let url = URL(string: "test")!
            let httpResponse = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: "2",
                headerFields: nil
            )!
            let data = NSDataAsset(name: "GoogleBooksSampleData")!.data

            return (httpResponse, data)
        }
    }

    func makeFailureResult() {
        MockURLProtocol.requestHandler = { _ in
            let url = URL(string: "test")!
            let httpResponse = HTTPURLResponse(
                url: url,
                statusCode: 400,
                httpVersion: "2",
                headerFields: nil
            )!
            let data = Data()

            return (httpResponse, data)
        }
    }

    func makeSuccessImageResult() {
        MockURLProtocol.requestHandler = { _ in
            let url = URL(string: "test")!
            let httpResponse = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: "2",
                headerFields: nil
            )!
            let imageData = UIImage(named: "MalrangImage")!.pngData()!

            return (httpResponse, imageData)
        }
    }
}
