//
//  MainInformationVIew.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

final class MainInformationVIew: UIView {
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 2
        return label
    }()

    private let authorsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
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
            self.imageView,
            self.titleLabel,
            self.authorsLabel
        )
    }

    private func setupConstraint() {
        self.contentsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(5)
        }
    }

    func bind(viewModel: DetailViewModelable) {
        self.imageView.setImage(with: viewModel.imageUrlString, placeholder: CustomImage.malrang)
        self.titleLabel.text = viewModel.title
        self.authorsLabel.text = viewModel.authors
    }
}
