//
//  UIImageView+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

extension UIImageView {
    private var imageDownloadTask: URLSessionDataTask? {
        get { objc_getAssociatedObject(self, "image") as? URLSessionDataTask }
        set { objc_setAssociatedObject(self, "image", newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func setImage(with urlstring: String, placeholder: UIImage? = nil) {
        self.imageDownloadTask?.suspend()
        self.imageDownloadTask?.cancel()

        let cache = ImageCacheManager.shared.cache

        if let cacheImage = cache.object(forKey: urlstring as NSString) {
            return self.image = cacheImage
        }

        self.imageDownloadTask = ImageDownloader.share.download(with: urlstring) { result in
            switch result {
            case .success(let image):
                cache.setObject(image, forKey: urlstring as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            case .failure:
                guard let placeholder = placeholder else { return }
                DispatchQueue.main.async {
                    self.image = placeholder
                }
                return
            }
        }
    }
}
