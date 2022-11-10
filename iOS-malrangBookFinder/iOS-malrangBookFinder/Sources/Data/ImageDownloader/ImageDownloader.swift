//
//  ImageDownloader.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

final class ImageDownloader {
    static let shared = ImageDownloader()
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func downloadImage(
        with urlString: String,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(ImageDownloadError.urlError))
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

