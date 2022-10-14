//
//  DetailScrollView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

import SnapKit

final class DetailScrollView: UIScrollView {
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
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

    private let descriptionView: DescriptionInformationView = {
        let descriptionView = DescriptionInformationView()
        descriptionView.clipsToBounds = true
        descriptionView.layer.cornerRadius = 10
        return descriptionView
    }()

    private let viewModel: DetailViewModelable

    init(viewModel: DetailViewModelable) {
        self.viewModel = viewModel
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
        self.setupConstraint()
        self.bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.showsVerticalScrollIndicator = false
        self.addSubview(self.contentsStackView)
        self.contentsStackView.addArrangedSubviews(
            self.mainInformationView,
            self.subInformationView,
            self.descriptionView
        )
    }

    private func setupConstraint() {
        self.contentsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        self.subInformationView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
    }

    private func bind() {
        self.mainInformationView.bind(viewModel: self.viewModel)
        self.subInformationView.bind(viewModel: self.viewModel)
        self.descriptionView.bind(viewModel: self.viewModel)
    }
}
