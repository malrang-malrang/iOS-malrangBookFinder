//
//  LoadingIndicatorView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/14.
//

import UIKit

private enum Const {
    static let loadingTextLabel = "책 목록을 가져오는 중이에요."
}

final class LoadingIndicatorView: UIView {
    private let contentsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = ColorPalette.malrangPink
        return activityIndicator
    }()

    private var loadingTextLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.attributedText = NSAttributedString(
            string: Const.loadingTextLabel,
            attributes: [.foregroundColor: ColorPalette.malrangPink]
        )
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.addSubview(self.contentsStackView)
        self.contentsStackView.addArrangedSubviews(self.loadingIndicator, self.loadingTextLabel)
    }

    private func setupConstraint() {
        self.contentsStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func startAnimating() {
        self.loadingIndicator.startAnimating()
        self.loadingTextLabel.isHidden = false
    }

    func stopAnimating() {
        self.loadingIndicator.stopAnimating()
        self.loadingTextLabel.isHidden = true
    }
}
