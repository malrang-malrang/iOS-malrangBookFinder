//
//  ImageDownloader.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

protocol ImageDownloadable {
    @discardableResult
    func downloadImage(
        with urlString: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask?
}

final class ImageDownloader: ImageDownloadable {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    @discardableResult
    func downloadImage(
        with urlString: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(ImageError.urlError))
            return nil
        }

        let task = session.dataTask(with: url) { data, response, error in

            if let error = error as? ImageError {
                return completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(ImageError.responseError))
            }

            guard (200..<300).contains(response.statusCode) else {
                return completion(.failure(ImageError.statusCodeError(statusCode: response.statusCode)))
            }

            guard let data = data else {
                return completion(.failure(ImageError.emptyDataError))
            }

            completion(.success(data))
        }
        task.resume()
        return task
    }
}
