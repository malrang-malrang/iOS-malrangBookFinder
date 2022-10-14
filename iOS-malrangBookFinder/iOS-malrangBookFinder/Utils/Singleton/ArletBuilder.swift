//
//  ArletBuilder.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

protocol Alertable  where Self: Coordinator {
    func showErrorAlert(title: String, message: String)
}

private enum Const {
    static let checkString = "확인"
    static let titleTextColorString = "titleTextColor"
}

extension Alertable {
    func showErrorAlert(title: String, message: String) {
        let checkAction = UIAlertAction(title: Const.checkString, style: .cancel)
        checkAction.setValue(
            ColorPalette.malrangDeepPink,
            forKey: Const.titleTextColorString
        )

        let alert = AlertBuilder.shared
            .setType(.alert)
            .setMessage(message)
            .setTitle(title)
            .setActions([checkAction])
            .build()

        self.navigationController.present(alert, animated: true)
    }
}

final class AlertBuilder {
    struct Product {
        var title: String?
        var message: String?
        var type: UIAlertController.Style = .alert
        var actions: [UIAlertAction] = []
    }

    static private let alertBuilder = AlertBuilder()
    static private var product = Product()

    static var shared: AlertBuilder {
        self.product = Product()

        return alertBuilder
    }

    private init() { }

    func setTitle(_ title: String) -> Self {
        Self.product.title = title

        return self
    }

    func setMessage(_ message: String?) -> Self {
        Self.product.message = message

        return self
    }

    func setType(_ type: UIAlertController.Style) -> Self {
        Self.product.type = type

        return self
    }

    func setActions(_ actions: [UIAlertAction]?) -> Self {
        guard let actions = actions else {
            return self
        }

        actions.forEach { Self.product.actions.append($0) }

        return self
    }

    func build() -> UIAlertController {
        let alert = UIAlertController(
            title: AlertBuilder.product.title,
            message: AlertBuilder.product.message,
            preferredStyle: AlertBuilder.product.type
        )

        AlertBuilder.product.actions.forEach {
            alert.addAction($0)
        }

        return alert
    }
}
