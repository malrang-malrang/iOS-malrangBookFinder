//
//  SearchViewModel.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import RxSwift
import RxRelay

protocol SearchViewModelable: SearchViewModelInput, SearchViewModelOutput {}

protocol SearchViewModelInput {
    func fetchFirstPage(text: String)
    func fetchNextPage()
}

protocol SearchViewModelOutput {
    var totalItems: Observable<Int> { get }
    var bookInformationList: Observable<[BookInformation]> { get }
    var error: Observable<Error> { get }
}

final class SearchViewModel: SearchViewModelable {
    private let useCase: BookListSearchUseCaseProtocol
    private let disposeBag = DisposeBag()
    private let bookInformationListRelay = PublishRelay<[BookInformation]>()
    private let totalItemsRelay = PublishRelay<Int>()
    private let errorRelay = PublishRelay<Error>()
    private var searchedBookList: [BookInformation] = []
    private var searchedText: String?
    private var startIndex = 0
    private var maxResult = 20

    init(useCase: BookListSearchUseCaseProtocol) {
        self.useCase = useCase
    }

    private func fetchBookList(text: String, startIndex: Int, maxResult: Int) {
//                로딩 애니메이션 로직
        self.useCase.searchBookList(text: text, startIndex: startIndex, maxResult: maxResult)
            .subscribe(onNext: { [weak self] searchResult in
                self?.checkResult(searchResult: searchResult)
            }, onError: { [weak self] error in
                self?.errorRelay.accept(error)
            }, onCompleted: {
                //로딩 제거 로직
            })
            .disposed(by: self.disposeBag)
    }

    private func checkResult(searchResult: SearchResult) {
        guard let totalItems = searchResult.totalItems,
              let items = searchResult.items else {
            self.errorRelay.accept(InputError.searchResultIsEmptyError)
            return
        }
        self.searchedBookList.append(contentsOf: items)
        self.totalItemsRelay.accept(totalItems)
        self.bookInformationListRelay.accept(searchedBookList + items)
    }

    // MARK: - Input

    func fetchFirstPage(text: String) {
        self.startIndex = 0
        self.maxResult = 20
        self.searchedText = text
        self.searchedBookList = []
        self.fetchBookList(
            text: text,
            startIndex: self.startIndex,
            maxResult: self.maxResult
        )
    }

    func fetchNextPage() {
        guard let searchedText = searchedText else {
            return
        }

        self.startIndex += self.maxResult
        self.fetchBookList(
            text: searchedText,
            startIndex: self.startIndex,
            maxResult: self.maxResult
        )
    }

    // MARK: - Output

    var totalItems: Observable<Int> {
        return self.totalItemsRelay.asObservable()
    }

    var bookInformationList: Observable<[BookInformation]> {
        return self.bookInformationListRelay.asObservable()
    }

    var error: Observable<Error> {
        return self.errorRelay.asObservable()
    }
}
