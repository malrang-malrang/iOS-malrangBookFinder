//
//  SearchResultCellViewModel.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import Foundation

protocol SearchResultCellViewModelable: SearchResultCellViewModelOutput {}

protocol SearchResultCellViewModelOutput {
    var imageUrlString: String? { get }
    var title: String { get }
    var authors: String { get }
    var publishedDate: String { get }
}

private enum Const {
    static let emptyInformation = "알 수 없음."
    static let emptyString = ""
    static let commaString = ","
}

final class SearchResultCellViewModel: SearchResultCellViewModelable {
    private let bookInformation: BookInformation

    init(bookInformation: BookInformation) {
        self.bookInformation = bookInformation
    }

    // MARK: - Output

    var imageUrlString: String? {
        return self.bookInformation.volumeInfo?.imageLinks?.thumbnail
    }

    var title: String {
        return self.bookInformation.volumeInfo?.title ?? Const.emptyInformation
    }

    var authors: String {
        guard let authors = self.bookInformation.volumeInfo?.authors else {
            return Const.emptyInformation
        }

        return authors.reduce(Const.emptyString) { $0 + Const.commaString + $1 }
    }

    var publishedDate: String {
        return self.bookInformation.volumeInfo?.publishedDate ?? Const.emptyInformation
    }
}
