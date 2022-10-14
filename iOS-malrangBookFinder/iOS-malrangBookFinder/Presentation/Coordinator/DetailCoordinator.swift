//
//  DetailCoordinator.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

protocol DetailCoordinatorProtocol: Alertable {
    func popDetailView()
}

final class DetailCoordinator: Coordinator, DetailCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let bookSearchUseCase: BookListSearchUseCaseProtocol

    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator? = nil,
        childCoordinators: [Coordinator] = [],
        bookSearchUseCase: BookListSearchUseCaseProtocol
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
        self.bookSearchUseCase = bookSearchUseCase
    }

    func start() {
        let detailView = DetailViewController(coordinator: self)
        self.navigationController.pushViewController(detailView, animated: true)
    }

    func popDetailView() {
        self.navigationController.popViewController(animated: true)
        self.parentCoordinators?.removeChild(self)
    }
}
