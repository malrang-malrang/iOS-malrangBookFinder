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

    private let mainInformationView: MainInformationVIew = {
        let mainInormationView = MainInformationVIew()
        mainInormationView.clipsToBounds = true
        mainInormationView.layer.cornerRadius = 10
        return mainInormationView
    }()

    private let subInformationView: SubInformationView = {
        let subInformationView = SubInformationView()
        subInformationView.clipsToBounds = true
        subInformationView.layer.cornerRadius = 10
        return subInformationView
    }()

    private let viewModel: DetailViewModelable
    private let coordinator: DetailCoordinator
    private let disposeBag = DisposeBag()

    init(viewModel: DetailViewModelable, coordinator: DetailCoordinator) {
        self.viewModel = viewModel
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
        self.view.addSubviews(self.mainInformationView, self.subInformationView)
    }

    private func setupConstraint() {
        self.mainInformationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview().dividedBy(3)
        }

        self.subInformationView.snp.makeConstraints {
            $0.top.equalTo(self.mainInformationView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalToSuperview().dividedBy(8)
        }
    }

    private func bind() {
        self.navigationItem.title = self.viewModel.title

        self.backBarButton.rx.tap
            .bind { [weak self] _ in
                self?.coordinator.popDetailView()
            }
            .disposed(by: self.disposeBag)

        self.mainInformationView.bind(viewModel: self.viewModel)
        self.subInformationView.bind(viewModel: self.viewModel)
    }
}
