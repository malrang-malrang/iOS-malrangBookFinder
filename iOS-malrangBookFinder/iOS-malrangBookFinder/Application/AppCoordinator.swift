//
//  AppCoordinator.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinators: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func removeChild(_ coordinator: Coordinator) {
        self.childCoordinators.removeAll()
    }
}

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let bookSearchUseCase = BookListSearchUseCase(googleBooksRepository: GoogleBooksRepository())

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let mainCoordinator = MainViewCoordinator(
            navigationController: self.navigationController,
            parentCoordinators: self,
            bookSearchUseCase: self.bookSearchUseCase
        )
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.start()
    }
}
