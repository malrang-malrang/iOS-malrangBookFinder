//
//  DetailViewModel.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import Foundation

protocol DetailViewModelable: DetailViewModelOutput {}

protocol DetailViewModelOutput {
    var imageUrlString: String { get }
    var title: String { get }
    var authors: String { get }
}

private enum Const {
    static let unknown = "알 수 없음"
    static let emptyString = ""
    static let commaString = ", "
}

final class DetailViewModel: DetailViewModelable {
    private let bookInformation: BookInformation

    init(bookInformation: BookInformation) {
        self.bookInformation = bookInformation
    }

    // MARK: -  Output

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

        if authors.count > 1 {
            return authors.joined(separator: Const.commaString)
        }

        return authors.first ?? Const.unknown
    }
}
