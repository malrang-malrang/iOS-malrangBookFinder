//
//  SubInformationView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

import SnapKit

private enum Const {
    static let bookInformation = "책 정보"
    static let category = "카테고리"
    static let pageCount = "쪽수"
}

final class SubInformationView: UIView {
    private let bookInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = Const.bookInformation
        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.text = Const.category
        return label
    }()

    private let categoryLabelInformation: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let pageCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.text = Const.pageCount
        return label
    }()

    private let pageCountInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubviews(
            self.bookInformationLabel,
            self.categoryLabel,
            self.categoryLabelInformation,
            self.pageCountLabel,
            self.pageCountInformationLabel
        )
    }

    private func setupConstraint() {
        self.bookInformationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        self.categoryLabel.snp.makeConstraints {
            $0.top.equalTo(self.bookInformationLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.bookInformationLabel.snp.leading)
        }

        self.categoryLabelInformation.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.top)
            $0.leading.equalTo(self.categoryLabel.snp.trailing).offset(10)
        }

        self.pageCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.categoryLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.bookInformationLabel.snp.leading)
        }

        self.pageCountInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.pageCountLabel.snp.top)
            $0.leading.equalTo(self.categoryLabel.snp.trailing).offset(10)
        }
    }

    func bind(viewModel: DetailViewModelable) {
        self.categoryLabelInformation.text = viewModel.categories
        self.pageCountInformationLabel.text = viewModel.pageCountString
    }
}
