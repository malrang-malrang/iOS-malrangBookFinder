//
//  AccessInformationDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct AccessInformationDTO: Decodable {
    let country: String?
    let viewability: String?
    let embeddable: Bool?
    let publicDomain: Bool?
    let textToSpeechPermission: String?
    let epub: EqubDTO?
    let pdf: PdfDTO?
    let webReaderLink: String?
    let accessViewStatus: String?
    let quoteSharingAllowed: Bool?
}

struct EqubDTO: Decodable {
    let isAvailable: Bool?
    let acsTokenLink: String?
}

struct PdfDTO: Decodable {
    let isAvailable: Bool?
}
