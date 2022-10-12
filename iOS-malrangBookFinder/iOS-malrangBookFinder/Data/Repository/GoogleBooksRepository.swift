//
//  GoogleBooksRepository.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import RxSwift

final class GoogleBooksRepository {
    private let networkManger: Networkable

    init(networkManger: Networkable = NetworkManager()) {
        self.networkManger = networkManger
    }

    func searchBookList(title: String) -> Observable<SearchResultDTO> {
        let endpoint = EndPointStrage.searchBookList(title: title).endpoint
        return self.networkManger.request(endPoint: endpoint)
            .decode(type: SearchResultDTO.self, decoder: Json.decoder)
    }
}