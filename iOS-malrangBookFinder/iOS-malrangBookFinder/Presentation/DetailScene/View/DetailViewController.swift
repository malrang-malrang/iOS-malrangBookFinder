//
//  DetailViewController.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import RxCocoa
import RxSwift
import SnapKit

final class DetailViewController: UIViewController {
    private let backBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            image: SystemImage.back,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .black
        return barButtonItem
    }()

    private let coordinator: DetailCoordinator
    private let disposeBag = DisposeBag()

    init(coordinator: DetailCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    private func setupNavigationItem() {
        self.navigationItem.leftBarButtonItem = self.backBarButton
    }

    private func setupView() {
        self.view.backgroundColor = ColorPalette.malrangPink
    }

    private func setupConstraint() {
    }

    private func bind() {
        self.backBarButton.rx.tap
            .bind { [weak self] _ in
                self?.coordinator.popDetailView()
            }
            .disposed(by: self.disposeBag)
    }
}
