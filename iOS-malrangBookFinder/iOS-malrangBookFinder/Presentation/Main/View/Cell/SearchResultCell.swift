//
//  SearchResultCell.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/13.
//

import UIKit

import SnapKit

final class SearchResultCell: UITableViewCell {
    static var identifier: String {
        return String(describing: Self.self)
    }

    private let thumbnailImageView: UIImageView = {
        let image = UIImage(named: "MalrangImage")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "책 이름"
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .systemGray
        label.text = "작가 이름"
        return label
    }()

    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemGray
        label.text = "출판한 날짜"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupContentView()
        self.setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupContentView() {
        self.accessoryType = .disclosureIndicator
        self.contentView.backgroundColor = .systemBackground
        self.contentView.addSubviews(
            self.thumbnailImageView,
            self.titleLabel,
            self.authorLabel,
            self.publishedDateLabel
        )
    }

    private func setupConstraint() {
        self.thumbnailImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview().dividedBy(4)
            $0.height.equalTo(self.thumbnailImageView.snp.width)
        }

        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.thumbnailImageView.snp.top)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(20)
        }

        self.authorLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.thumbnailImageView.snp.centerY)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(20)
        }

        self.publishedDateLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.thumbnailImageView.snp.bottom)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(20)
        }
    }

    func configure(viewModel: SearchResultCellViewModelable) {
        self.titleLabel.text = viewModel.title
        self.authorLabel.text = viewModel.authors
        self.publishedDateLabel.text = viewModel.publishedDate
    }
}
