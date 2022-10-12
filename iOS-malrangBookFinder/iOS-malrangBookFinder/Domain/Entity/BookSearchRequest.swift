//
//  BookSearchRequest.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

enum Projection: String, Encodable {
    case full = "full"
    case lite = "lite"

    var value: String {
        return self.rawValue
    }
}

struct BookSearchRequest: Encodable {
    let q: String?
    let startIndex: Int?
    let maxResult: Int?
    let projection: Projection?

    init(
        title: String?,
        startIndex: Int?,
        maxResult: Int?,
        projection: Projection?
    ) {
        self.q = title
        self.startIndex = startIndex
        self.maxResult = maxResult
        self.projection = projection
    }
}
