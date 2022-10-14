//
//  MainCoordinator.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import UIKit

protocol MainViewCoordinatorProtocol: Alertable {}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol {
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
        let searchViewModel = SearchViewModel(useCase: self.bookSearchUseCase)
        let mainView = MainViewController(searchViewModel: searchViewModel, coordinator: self)
        self.navigationController.pushViewController(mainView, animated: true)
    }
}
