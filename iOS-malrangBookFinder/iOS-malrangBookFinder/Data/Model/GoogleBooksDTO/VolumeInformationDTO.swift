//
//  VolumeInformationDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct VolumeInformationDTO: Decodable {
    let title: String?
    let subtitle: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let industryIdentifiers: [IndustryIdentifiersDTO]?
    let readingModes: ReadingModesDTO?
    let pageCount: Int?
    let printedPageCount: Int?
    let dimensions: DimensionsDTO?
    let printType: String?
    let categories: [String]?
    let averageRating: Double?
    let ratingCount: Int?
    let maturityRating: String?
    let allowAnonLogging: Bool?
    let contentVersion: String?
    let panelizationSummary: PanelizationSummaryDTO?
    let imageLinks: ImageLinksDTO?
    let language: String?
    let previewLink: String?
    let infoLink: String?
    let canonicalVolumeLink: String?
}

extension VolumeInformationDTO {
    func toDomain() -> VolumeInformation {
        return VolumeInformation(
            title: self.title,
            authors: self.authors,
            publisher: self.publisher,
            publishedDate: self.publishedDate,
            description: self.description,
            pageCount: self.pageCount,
            categories: self.categories,
            imageLinks: self.imageLinks?.toDomain()
        )
    }
}
