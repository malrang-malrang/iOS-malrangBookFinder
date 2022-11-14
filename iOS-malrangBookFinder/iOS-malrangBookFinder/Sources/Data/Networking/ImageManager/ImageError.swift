//
//  ImageError.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import Foundation

enum ImageError: LocalizedError {
    case unknownError
    case statusCodeError(statusCode: Int)
    case emptyDataError
    case responseError
    case imageConvertError
    case urlError

    var errorMessage: String {
        switch self {
        case .unknownError:
            return "알 수 없는 에러입니다."
        case .statusCodeError(let statusCode):
            return "status코드가 200~299가 아닌, \(statusCode)입니다."
        case .emptyDataError:
            return "data가 비어있습니다."
        case .responseError:
            return "response 수신을 실패 했습니다."
        case .imageConvertError:
            return "이미지 변환에 실패 했습니다."
        case .urlError:
            return "URL이 잘못되었습니다."
        }
    }
}
