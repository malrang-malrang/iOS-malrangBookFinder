//
//  DownloadableImageView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/11/12.
//

import UIKit

final class DownloadableImageView: UIImageView {
    var task: URLSessionDataTask?

    func cancelTask() {
        self.task?.suspend()
        self.task?.cancel()
    }

    func setImage(urlString: String, placeholder: UIImage? = nil) {
        let cacheManager = CacheManager.shared

        if let cacheImage = cacheManager.getImage(key: urlString) {
            self.loadOnMainScheduler(image: cacheImage)
            return
        }

        self.task = ImageDownloader.shared.downloadImage(with: urlString) { result in
            switch result {
            case .success(let image):
                cacheManager.saveImage(key: urlString, image: image)
                return self.loadOnMainScheduler(image: image)
            case .failure:
                guard let placeholder = placeholder else { return }
                return self.loadOnMainScheduler(image: placeholder)
            }
        }
    }

    private func loadOnMainScheduler(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}

