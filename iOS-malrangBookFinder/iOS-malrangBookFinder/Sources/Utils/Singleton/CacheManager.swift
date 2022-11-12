//
//  CacheManager.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

final class CacheManager {
    static let shared = CacheManager()

    private let imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        return cache
    }()

    private init() {}

    func getImage(key: String) -> UIImage? {
        return self.imageCache.object(forKey: key as NSString)
    }

    func saveImage(key: String, image: UIImage) {
        self.imageCache.setObject(image, forKey: key as NSString)
    }
}
