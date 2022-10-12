//
//  Encodable+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

extension Encodable {
    func toDictionary() -> Result<[String: Any], NetworkError> {
        do {
            let jsonData = try Json.encoder.encode(self)
            guard let dictionaryData = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
                return .failure(.decodeError)
            }
            return .success(dictionaryData)
        } catch {
            return .failure(.decodeError)
        }
    }
}
