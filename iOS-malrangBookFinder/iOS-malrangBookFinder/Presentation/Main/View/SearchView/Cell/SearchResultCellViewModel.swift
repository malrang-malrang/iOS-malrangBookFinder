//
//  SearchResultCellViewModel.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import Foundation

protocol SearchResultCellViewModelable: SearchResultCellViewModelOutput {}

protocol SearchResultCellViewModelOutput {
    var imageUrlString: String { get }
    var title: String { get }
    var authors: String { get }
    var publishedDate: String { get }
}

private enum Const {
    static let unknown = "알 수 없음"
    static let emptyString = ""
    static let authorsInformation = "%@ 외 %d명"
}

final class SearchResultCellViewModel: SearchResultCellViewModelable {
    private let bookInformation: BookInformation

    init(bookInformation: BookInformation) {
        self.bookInformation = bookInformation
    }

    // MARK: - Output

    var imageUrlString: String {
        return self.bookInformation.volumeInfo?.imageLinks?.thumbnail ?? Const.emptyString
    }

    var title: String {
        return self.bookInformation.volumeInfo?.title ?? Const.unknown
    }

    var authors: String {
        guard let authors = self.bookInformation.volumeInfo?.authors else {
            return Const.unknown
        }

        if authors.count > 1, let author = authors.first {
            return String(format: Const.authorsInformation, author, authors.count - 1)
        }

        return authors.first ?? Const.unknown
    }

    var publishedDate: String {
        return self.bookInformation.volumeInfo?.publishedDate ?? Const.unknown
    }
}
