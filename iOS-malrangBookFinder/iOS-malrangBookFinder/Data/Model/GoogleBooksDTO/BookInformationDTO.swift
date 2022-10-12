//
//  BookInformationDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct BookInformationDTO: Decodable {
    let kind: String?
    let id: String?
    let selfLink: String?
    let etag: String?
    let volumeInfo: VolumeInformationDTO?
    let layerInfo: LayerInfoDTO?
    let saleInfo: SaleInformationDTO?
    let accessInfo: AccessInformationDTO?
}
