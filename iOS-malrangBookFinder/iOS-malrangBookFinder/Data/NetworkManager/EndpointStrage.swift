//
//  EndpointStrage.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

private enum Const {
    static let baseURL = "https://www.googleapis.com"
    static let basePath = "/books/v1/volumes/"
}

enum EndPointStrage {
    case searchBookList(title: String, startIndex: Int, maxResult: Int)
}

extension EndPointStrage {
    var endpoint: Endpoint {
        switch self {
        case .searchBookList(
            title: let title,
            startIndex: let startIndex,
            maxResult: let maxResult
        ):
            return self.searchBookList(
                text: title,
                startIndex: startIndex,
                maxResult: maxResult
            )
        }
    }
}

extension EndPointStrage {
    private func searchBookList(
        text: String,
        startIndex: Int,
        maxResult: Int
    ) -> Endpoint {
        let queryParameter = BookSearchRequest(
            title: text,
            startIndex: startIndex,
            maxResult: maxResult,
            projection: .full
        )

        let endpoint = Endpoint(
            host: Const.baseURL,
            path: Const.basePath,
            method: .get,
            queryParameters: queryParameter
        )

        return endpoint
    }
}
