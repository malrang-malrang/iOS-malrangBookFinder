//
//  Requestable.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

protocol Requestable {
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameters: Encodable { get }
}

extension Requestable {
    func generateUrlRequest() -> Result<URLRequest, NetworkError> {
        var urlRequest: URLRequest

        switch self.generateURL() {
        case.success(let url):
            urlRequest = URLRequest(url: url)
        case.failure(let error):
            return .failure(error)
        }

        urlRequest.httpMethod = self.method.value

        return .success(urlRequest)
    }

    private func generateURL() -> Result<URL, NetworkError> {
        let fullPath = "\(self.host)\(self.path)"

        guard var urlComponent = URLComponents(string: fullPath) else {
            return .failure(.urlComponetError)
        }

        switch self.generateQueryItems(at: self.queryParameters) {
        case .success(let queryItems):
            urlComponent.queryItems = queryItems
        case .failure(let error):
            return .failure(error)
        }

        guard let url = urlComponent.url else {
            return .failure(.urlError)
        }

        return .success(url)
    }

    private func generateQueryItems(at queryParameters: Encodable) -> Result<[URLQueryItem], NetworkError> {
        var urlQueryItems: [URLQueryItem] = []

        switch queryParameters.toDictionary() {
        case .success(let dictionaryData):
            dictionaryData.forEach { key, value in
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlQueryItems.append(queryItem)
            }
        case .failure(let error):
            return .failure(error)
        }

        return .success(urlQueryItems)
    }
}

