//
//  SearchResultDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct SearchResultDTO: Decodable {
    let kind: String?
    let totalItems: Int?
    let items: [BookInformationDTO]?
}

extension SearchResultDTO {
    func toDomain() -> SearchResult {
        return SearchResult(
            totalItems: self.totalItems,
            items: self.items?.map { $0.toDomain() }
        )
    }
}
