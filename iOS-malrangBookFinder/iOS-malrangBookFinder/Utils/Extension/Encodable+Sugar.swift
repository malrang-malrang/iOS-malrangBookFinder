//
//  Encodable+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import Foundation

extension Encodable {
    func toDictionary() -> Result<[String: Any], NetworkError> {
        guard let jsonData = try? Json.encoder.encode(self) else {
            return .failure(.encodeError)
        }

        guard let dictionaryData = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            return .failure(.encodeError)
        }

        return .success(dictionaryData)
    }
}
