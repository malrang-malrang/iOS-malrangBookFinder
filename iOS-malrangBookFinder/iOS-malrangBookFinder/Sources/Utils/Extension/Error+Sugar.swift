//
//  Error+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import Foundation

extension Error {
    var identifier: String {
        if let networkError = self as? NetworkError {
            return String(describing: networkError.self)
        }

        if let imageDownloadError = self as? ImageDownloadError {
            return String(describing: imageDownloadError.self)
        }

        if let inputError = self as? InputError {
            return String(describing: inputError.self)
        }

        return String(describing: Self.self)
    }

    var errorMessage: String {
        if let networkError = self as? NetworkError {
            return networkError.errorMessage
        }

        if let imageDownloadError = self as? ImageDownloadError {
            return imageDownloadError.errorMessage
        }

        if let inputError = self as? InputError {
            return inputError.errorMessage
        }

        return self.localizedDescription
    }
}
