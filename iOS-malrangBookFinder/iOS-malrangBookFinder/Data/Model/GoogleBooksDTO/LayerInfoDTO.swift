//
//  LayerInfoDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct LayerInfoDTO: Decodable {
    let layers: [LayersDTO]?
}

struct LayersDTO: Decodable {
    let layerId: String?
    let volumeAnnotationsVersion: String?
}
