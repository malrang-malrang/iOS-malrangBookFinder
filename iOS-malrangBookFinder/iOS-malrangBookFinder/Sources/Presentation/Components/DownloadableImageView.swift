//
//  DownloadableImageView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/11/12.
//

import UIKit

final class DownloadableImageView: UIImageView {
    private var task: URLSessionDataTask?

    func cancelTask() {
        self.task?.suspend()
        self.task?.cancel()
    }

    func setImage(urlString: String, placeholder: UIImage? = nil) {
        self.task = ImageManager.shared.retriveImage(with: urlString) { result in
            switch result {
            case .success(let image):
                self.loadOnMainScheduler(image: image)
            case .failure(let error):
                print(error.identifier, error.errorMessage)
                guard let placeholder = placeholder else { return }
                self.loadOnMainScheduler(image: placeholder)
            }
        }
    }

    private func loadOnMainScheduler(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.image = image
        }
    }
}

