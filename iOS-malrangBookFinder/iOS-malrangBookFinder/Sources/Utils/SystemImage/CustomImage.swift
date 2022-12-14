//
//  SystemImage.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

enum CustomImage {
    enum Atribute {
        static let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .heavy)
    }

    static let malrang = UIImage(named: "MalrangImage")

    static let back = UIImage(
        systemName: "arrowshape.turn.up.backward.fill",
        withConfiguration: Atribute.configuration
    )
}
