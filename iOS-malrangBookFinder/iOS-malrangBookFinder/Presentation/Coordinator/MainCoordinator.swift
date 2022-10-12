//
//  MainCoordinator.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import UIKit

protocol MainViewCoordinatorProtocol {

}

final class MainViewCoordinator: Coordinator, MainViewCoordinatorProtocol {
    var navigationController: UINavigationController
    var parentCoordinators: Coordinator?
    var childCoordinators: [Coordinator] = []

    init(
        navigationController: UINavigationController,
        parentCoordinators: Coordinator? = nil,
        childCoordinators: [Coordinator] = []
    ) {
        self.navigationController = navigationController
        self.parentCoordinators = parentCoordinators
    }

    func start() {

    }
}
