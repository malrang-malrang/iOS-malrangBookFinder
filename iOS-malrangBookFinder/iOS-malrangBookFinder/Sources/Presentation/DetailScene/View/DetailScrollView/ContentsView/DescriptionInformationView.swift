//
//  DescriptionInformationView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

import SnapKit

private enum Const {
    static let bookDiscription = "책 소개"
}

final class DescriptionInformationView: UIView {
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()

    private let bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = Const.bookDiscription
        return label
    }()

    private let descriptionInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 0
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
        self.addSubview(self.contentsStackView)
        self.contentsStackView.addArrangedSubviews(
            self.bookDescriptionLabel,
            self.descriptionInformationLabel
        )
    }

    private func setupConstraint() {
        self.contentsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }

    func bind(description: String) {
        self.descriptionInformationLabel.text = description
    }
}
