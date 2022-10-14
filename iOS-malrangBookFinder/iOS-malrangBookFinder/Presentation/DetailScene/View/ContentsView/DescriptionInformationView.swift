//
//  DescriptionInformationView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

private enum Const {
    static let bookDiscription = "책 소개"
}

final class DescriptionInformationView: UIView {
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
        self.addSubviews(self.bookDescriptionLabel, self.descriptionInformationLabel)
    }

    private func setupConstraint() {
        self.bookDescriptionLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        self.descriptionInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.bookDescriptionLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.bookDescriptionLabel.snp.leading)
        }
    }

    func bind(viewModel: DetailViewModelable) {
        self.descriptionInformationLabel.text = viewModel.description
    }
}
