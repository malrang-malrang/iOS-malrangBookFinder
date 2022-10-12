//
//  NetworError.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case statusCodeError(statusCode: Int)
    case urlComponetError
    case urlError
    case emptyDataError
    case decodeError
    case responseError

    var errorDescription: String {
        switch self {
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .statusCodeError(let statusCode):
            return "status코드가 200~299가 아닌, \(statusCode)입니다."
        case .urlComponetError:
            return "URL components 생성 에러가 발생했습니다."
        case .urlError:
            return "URL 생성 에러가 발생했습니다."
        case .emptyDataError:
            return "data가 비어있습니다."
        case .decodeError:
            return "decode 에러가 발생했습니다."
        case .responseError:
            return "response 수신을 실패 했습니다."
        }
    }
}
