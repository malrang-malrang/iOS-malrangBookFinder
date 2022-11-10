//
//  UIImageView+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

extension UIImageView {

    @discardableResult
    func setImage(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        let cacheManager = ImageCacheManager.shared

        if let cacheImage = cacheManager.getImage(key: urlString) {
            self.loadOnMainScheduler(image: cacheImage)
            return nil
        }

        let task = ImageDownloader.shared.downloadImage(with: urlString) { result in
            switch result {
            case .success(let image):
                cacheManager.saveImage(key: urlString, image: image)
                return self.loadOnMainScheduler(image: image)
            case .failure:
                guard let placeholder = placeholder else { return }
                return self.loadOnMainScheduler(image: placeholder)
            }
        }

        return task
    }

    private func loadOnMainScheduler(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}
