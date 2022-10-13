//
//  BookListSearchUseCase.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import RxSwift

protocol BookListSearchUseCaseProtocol {
    func searchBookList(
        text: String,
        startIndex: Int,
        maxResult: Int
    ) -> Observable<SearchResult>
}

final class BookListSearchUseCase: BookListSearchUseCaseProtocol {
    private let googleBooksRepository: GoogleBooksRepositoryProtocol

    init(googleBooksRepository: GoogleBooksRepositoryProtocol) {
        self.googleBooksRepository = googleBooksRepository
    }

    func searchBookList(
        text: String,
        startIndex: Int,
        maxResult: Int
    ) -> Observable<SearchResult> {
        return self.googleBooksRepository.searchBookList(
            title: text,
            startIndex: startIndex,
            maxResult: maxResult
        )
    }
}
