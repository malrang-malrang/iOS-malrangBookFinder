//
//  IndustryIdentifiersDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct IndustryIdentifiersDTO: Decodable {
    let type: String?
    let isbn: String?

    private enum CodingKeys: String, CodingKey {
        case type
        case isbn = "identifier"
    }
}
