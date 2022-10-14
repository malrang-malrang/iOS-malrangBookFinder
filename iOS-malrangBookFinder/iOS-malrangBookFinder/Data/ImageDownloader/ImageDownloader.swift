//
//  ImageDownloader.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

final class ImageDownloader {
    static let share = ImageDownloader()

    private var sessionConfiguration = URLSessionConfiguration.ephemeral
    private let session: URLSession

    init() {
        self.session = URLSession(
            configuration: self.sessionConfiguration,
            delegate: nil,
            delegateQueue: nil
        )
    }

    @discardableResult
    func download(
        with urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            return nil
        }

        let task = session.dataTask(with: url) { data, response, error in

            if let error = error as? ImageDownloadError {
                return completion(.failure(error))
            }

            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(ImageDownloadError.responseError))
            }

            guard (200..<300).contains(response.statusCode) else {
                return completion(.failure(ImageDownloadError.statusCodeError(statusCode: response.statusCode)))
            }

            guard let data = data else {
                return completion(.failure(ImageDownloadError.emptyDataError))
            }

            guard let image = UIImage(data: data) else {
                return completion(.failure(ImageDownloadError.imageConvertError))
            }

            completion(.success(image))
        }
        task.resume()
        return task
    }
}
