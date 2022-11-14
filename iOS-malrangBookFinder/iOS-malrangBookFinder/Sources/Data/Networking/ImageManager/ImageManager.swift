//
//  ImageManager.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/11/12.
//

import UIKit

final class ImageManager {
    static let shared = ImageManager()
    private let downloader: ImageDownloadable
    private let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()

    init(downloader: ImageDownloader = ImageDownloader()) {
        self.downloader = downloader
    }

    @discardableResult
    func retriveImage(
        with: String,
        completion: @escaping (Result<UIImage, Error>)-> Void
    ) -> URLSessionDataTask? {
        if let cachedImage = self.imageCache.object(forKey: with as NSString) {
            completion(.success(cachedImage))
            return nil
        }

        let task = self.downloader.downloadImage(with: with) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    return completion(.failure(ImageError.imageConvertError))
                }
                self.imageCache.setObject(image, forKey: with as NSString)
                return completion(.success(image))
            case .failure(let error):
                return completion(.failure(error))
            }
        }
        task?.resume()

        return task
    }
}
