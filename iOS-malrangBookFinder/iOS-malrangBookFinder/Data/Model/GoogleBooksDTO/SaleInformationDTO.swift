//
//  SaleInformationDTO.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

struct SaleInformationDTO: Decodable {
    let country: String?
    let saleability: String?
    let isEbook: Bool?
    let listPrice: PriceDTO?
    let retailPrice: PriceDTO?
    let buyLink: String?
}

struct PriceDTO: Decodable {
    let amount: Int?
    let currencyCode: String?
}
