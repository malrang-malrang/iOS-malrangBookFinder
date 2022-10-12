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
    case searchBookList(title: String)
}

extension EndPointStrage {
    var endpoint: Endpoint {
        switch self {
        case .searchBookList(title: let title):
            return self.searchBookList(title: title)
        }
    }
}

extension EndPointStrage {
    private func searchBookList(title: String) -> Endpoint {
        let queryParameter = BookSearchRequest(
            title: title,
            startIndex: 0,
            maxResult: 20,
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
