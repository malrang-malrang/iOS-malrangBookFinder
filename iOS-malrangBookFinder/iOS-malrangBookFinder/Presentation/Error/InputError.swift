//
//  InputError.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import Foundation

enum InputError: LocalizedError {
    case searchResultIsEmptyError

    var errorMessage: String {
        switch self {
        case .searchResultIsEmptyError:
            return "검색 결과가 없습니다."
        }
    }
}
