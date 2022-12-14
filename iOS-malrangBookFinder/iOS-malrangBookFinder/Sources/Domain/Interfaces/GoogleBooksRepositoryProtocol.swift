//
//  GoogleBooksRepositoryProtocol.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import RxSwift

protocol GoogleBooksRepositoryProtocol {
    func searchBookList(
        text: String,
        startIndex: Int,
        maxResult: Int
    ) -> Observable<SearchResult>
}
