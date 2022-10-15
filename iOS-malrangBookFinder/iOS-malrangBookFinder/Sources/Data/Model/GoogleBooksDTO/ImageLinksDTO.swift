//
//  ImageLinksDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct ImageLinksDTO: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
    let extraLarge: String?
}

extension ImageLinksDTO {
    func toDomain() -> ImageLinks {
        return ImageLinks(thumbnail: self.thumbnail, small: self.small)
    }
}
