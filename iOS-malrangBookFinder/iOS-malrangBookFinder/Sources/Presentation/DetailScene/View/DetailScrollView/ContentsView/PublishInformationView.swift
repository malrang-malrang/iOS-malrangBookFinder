//
//  PublishInformationView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/15.
//

import UIKit

import SnapKit

private enum Const {
    static let publishInformation = "출판 정보"
    static let publisher = "출판사"
    static let publishedDate = "출판일"
}

final class PublishInformationView: UIView {
    private let publishInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = Const.publishInformation
        return label
    }()

    private let publisherLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.text = Const.publisher
        return label
    }()

    private let publisherInformationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.text = Const.publishedDate
        return label
    }()

    private let publishedDateInformation: UILabel = {
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
            self.publishInformationLabel,
            self.publisherLabel,
            self.publisherInformationLabel,
            self.publishedDateLabel,
            self.publishedDateInformation
        )
    }

    private func setupConstraint() {
        self.publishInformationLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }

        self.publisherLabel.snp.makeConstraints {
            $0.top.equalTo(self.publishInformationLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.publishInformationLabel.snp.leading)
        }

        self.publisherInformationLabel.snp.makeConstraints {
            $0.top.equalTo(self.publisherLabel.snp.top)
            $0.leading.equalTo(self.publisherLabel.snp.trailing).offset(10)
        }

        self.publishedDateLabel.snp.makeConstraints {
            $0.top.equalTo(self.publisherLabel.snp.bottom).offset(10)
            $0.leading.equalTo(self.publisherLabel.snp.leading)
        }

        self.publishedDateInformation.snp.makeConstraints {
            $0.top.equalTo(self.publishedDateLabel.snp.top)
            $0.leading.equalTo(self.publishedDateLabel.snp.trailing).offset(10)
        }
    }

    func bind(publisher: String, publishedDate: String) {
        self.publisherInformationLabel.text = publisher
        self.publishedDateInformation.text = publishedDate
    }
}
