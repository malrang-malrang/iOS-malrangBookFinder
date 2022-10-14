//
//  SubInformationView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

private enum Const {
    static let bookInformation = "책 정보"
    static let category = "카테고리"
    static let totalPageNumber = "쪽수"
}

final class SubInformationView: UIView {
    private let bookInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = Const.bookInformation
        return label
    }()

    private let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
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
        label.text = Const.category
        return label
    }()

    private let totalPageNumberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()

    private let totalPageNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.text = Const.totalPageNumber
        return label
    }()

    private let totalPageNumberInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.text = Const.totalPageNumber
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
            self.categoryStackView,
            self.totalPageNumberStackView
        )

        self.categoryStackView.addArrangedSubviews(
            self.categoryLabel,
            self.categoryLabelInformation
        )

        self.totalPageNumberStackView.addArrangedSubviews(
            self.totalPageNumberLabel,
            self.totalPageNumberInformationLabel
        )
    }

    private func setupConstraint() {
        self.bookInformationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        self.categoryStackView.snp.makeConstraints {
            $0.top.equalTo(self.bookInformationLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.bookInformationLabel.snp.leading)
        }

        self.totalPageNumberStackView.snp.makeConstraints {
            $0.top.equalTo(self.categoryStackView.snp.bottom).offset(10)
            $0.leading.equalTo(self.bookInformationLabel.snp.leading)
        }
    }

    func bind(viewModel: DetailViewModelable) {

    }
}
