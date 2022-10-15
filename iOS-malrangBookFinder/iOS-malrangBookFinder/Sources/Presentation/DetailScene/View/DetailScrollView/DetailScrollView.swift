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

    private let descriptionInformationView: DescriptionInformationView = {
        let descriptionView = DescriptionInformationView()
        descriptionView.clipsToBounds = true
        descriptionView.layer.cornerRadius = 10
        return descriptionView
    }()

    private let publishInformationView: PublishInformationView = {
        let publishInformationView = PublishInformationView()
        publishInformationView.clipsToBounds = true
        publishInformationView.layer.cornerRadius = 10
        return publishInformationView
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
            self.descriptionInformationView,
            self.publishInformationView
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

        self.publishInformationView.snp.makeConstraints {
            $0.height.equalTo(110)
        }
    }

    private func bind() {
        self.mainInformationView.bind(
            imageUrlString: self.viewModel.imageUrlString,
            title: self.viewModel.title,
            authors: self.viewModel.authors
        )
        
        self.subInformationView.bind(
            categories: self.viewModel.categories,
            pageCount: self.viewModel.pageCountString
        )

        self.descriptionInformationView.bind(
            description: self.viewModel.description
        )

        self.publishInformationView.bind(
            publisher: self.viewModel.publisher,
            publishedDate: self.viewModel.publishedDateString
        )
    }
}
