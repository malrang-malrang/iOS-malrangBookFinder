//
//  Endpoint.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

final class Endpoint: Requestable {
    var host: String
    var path: String
    var method: HttpMethod
    var queryParameters: Encodable?

    init(
        host: String,
        path: String = "",
        method: HttpMethod = .get,
        queryParameters: Encodable? = nil
    ) {
        self.host = host
        self.path = path
        self.method = method
        self.queryParameters = queryParameters
    }
}
