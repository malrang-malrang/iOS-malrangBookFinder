//
//  UIView+Sugar.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
