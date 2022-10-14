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

    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()

    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()

    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        return label
    }()

    private let publishedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
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
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.addArrangedSubviews(
            self.thumbnailImageView,
            self.informationStackView
        )
        self.informationStackView.addArrangedSubviews(
            self.titleLabel,
            self.authorLabel,
            self.publishedDateLabel
        )
    }

    private func setupConstraint() {
        self.contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }

        self.thumbnailImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.3)
            $0.height.equalTo(self.thumbnailImageView.snp.width)
        }
    }

    func bind(viewModel: SearchResultCellViewModelable) {
        self.thumbnailImageView.setImage(with: viewModel.imageUrlString)
        self.titleLabel.text = viewModel.title
        self.authorLabel.text = viewModel.authors
        self.publishedDateLabel.text = viewModel.publishedDate
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.authorLabel.text = nil
        self.publishedDateLabel.text = nil
    }
}
