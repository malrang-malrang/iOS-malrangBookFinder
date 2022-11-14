//
//  GoogleBooksRepository.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import RxSwift

final class GoogleBooksRepository: GoogleBooksRepositoryProtocol {
    private let networkManger: Networkable

    init(networkManger: Networkable = NetworkManager()) {
        self.networkManger = networkManger
    }

    func searchBookList(
        text: String,
        startIndex: Int,
        maxResult: Int
    ) -> Observable<SearchResult> {
        let endpoint = EndpointStorage.searchBookList(
            title: text,
            startIndex: startIndex,
            maxResult: maxResult
        ).endpoint
        return self.networkManger.request(endPoint: endpoint)
            .decode(type: SearchResultDTO.self, decoder: Json.decoder)
            .map { $0.toDomain() }
    }
}
