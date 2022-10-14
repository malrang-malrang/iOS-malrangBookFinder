//
//  SearchResult.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import Foundation

struct SearchResult {
    let totalItems: Int?
    let items: [BookInformation]?
}

struct BookInformation {
    let volumeInfo: VolumeInformation?
}

struct VolumeInformation {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: ImageLinks?
}

struct ImageLinks {
    let thumbnail: String?
    let small: String?
}

