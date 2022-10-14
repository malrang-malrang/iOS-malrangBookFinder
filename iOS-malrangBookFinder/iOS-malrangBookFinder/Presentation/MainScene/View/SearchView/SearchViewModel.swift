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
    func fetchNextPage(lastRow: Int?)
}

protocol SearchViewModelOutput {
    var totalItems: Observable<Int> { get }
    var bookInformationList: Observable<[BookInformation]> { get }
    var error: Observable<Error> { get }
    var startLoading: Observable<Void> { get }
    var stopLoading: Observable<Void> { get }
}

private enum Const {
    static let emptyString = ""
}

final class SearchViewModel: SearchViewModelable {
    private let useCase: BookListSearchUseCaseProtocol
    private let disposeBag = DisposeBag()
    private let bookInformationListRelay = BehaviorRelay<[BookInformation]>(value: [])
    private let totalItemsRelay = BehaviorRelay<Int>(value: 0)
    private let errorRelay = PublishRelay<Error>()
    private let startLoadingRelay = PublishRelay<Void>()
    private let stopLoadingRelay = PublishRelay<Void>()
    private var searchedText: String?
    private var startIndex = 0
    private var maxResult = 20

    init(useCase: BookListSearchUseCaseProtocol) {
        self.useCase = useCase
    }

    private func fetchBookList(text: String, startIndex: Int, maxResult: Int) {
        self.startLoadingRelay.accept(())
        self.useCase.searchBookList(text: text, startIndex: startIndex, maxResult: maxResult)
            .subscribe(onNext: { [weak self] searchResult in
                self?.checkResult(searchResult: searchResult)
            }, onError: { [weak self] error in
                self?.errorRelay.accept(error)
            }, onCompleted: {
                self.stopLoadingRelay.accept(())
            })
            .disposed(by: self.disposeBag)
    }

    private func checkResult(searchResult: SearchResult) {
        guard let totalItems = searchResult.totalItems,
              let items = searchResult.items else {
            return self.errorRelay.accept(InputError.searchResultIsEmptyError)
        }
        self.totalItemsRelay.accept(totalItems)
        self.bookInformationListRelay.accept(self.bookInformationListRelay.value + items)
    }

    private func clearResult() {
        self.searchedText = nil
        self.totalItemsRelay.accept(0)
        self.bookInformationListRelay.accept([])
        self.stopLoadingRelay.accept(())
    }

    // MARK: - Input

    func fetchFirstPage(text: String) {
        if text == Const.emptyString {
            return self.clearResult()
        }

        self.startIndex = 0
        self.maxResult = 20
        self.searchedText = text
        self.bookInformationListRelay.accept([])
        self.fetchBookList(
            text: text,
            startIndex: self.startIndex,
            maxResult: self.maxResult
        )
    }

    func fetchNextPage(lastRow: Int?) {
        guard let searchedText = searchedText else { return }

        if lastRow == self.bookInformationListRelay.value.count - 1 {
            self.startIndex += self.maxResult
            self.fetchBookList(
                text: searchedText,
                startIndex: self.startIndex,
                maxResult: self.maxResult
            )
        }
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

    var startLoading: Observable<Void> {
        return self.startLoadingRelay.asObservable()
    }

    var stopLoading: Observable<Void> {
        return self.stopLoadingRelay.asObservable()
    }
}
