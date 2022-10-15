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
            image: CustomImage.back,
            style: .plain,
            target: nil,
            action: nil
        )
        barButtonItem.tintColor = .black
        return barButtonItem
    }()

    private let viewModel: DetailViewModelable
    private let detailScrollView: DetailScrollView
    private let coordinator: DetailCoordinator
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable, coordinator: DetailCoordinator) {
        self.viewModel = viewModel
        self.detailScrollView = DetailScrollView(viewModel: viewModel)
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
        self.view.addSubview(self.detailScrollView)
    }

    private func setupConstraint() {
        self.detailScrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().inset(10)
        }
    }

    private func bind() {
        self.navigationItem.title = self.viewModel.title
        
        self.backBarButton.rx.tap
            .bind { [weak self] _ in
                self?.coordinator.popDetailView()
            }
            .disposed(by: self.disposeBag)
    }
}
