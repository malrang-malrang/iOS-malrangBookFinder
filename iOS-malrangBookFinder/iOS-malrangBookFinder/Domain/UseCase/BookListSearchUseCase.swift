//
//  BookListSearchUseCase.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import RxSwift

protocol UseCaseProtocol {
    func searchBookList(title: String) -> Observable<SearchResult>
}

final class BookListSearchUseCase: UseCaseProtocol {
    private let googleBooksRepository: GoogleBooksRepositoryProtocol

    init(googleBooksRepository: GoogleBooksRepositoryProtocol) {
        self.googleBooksRepository = googleBooksRepository
    }

    func searchBookList(title: String) -> Observable<SearchResult> {
        return self.googleBooksRepository.searchBookList(title: title)
    }
}
