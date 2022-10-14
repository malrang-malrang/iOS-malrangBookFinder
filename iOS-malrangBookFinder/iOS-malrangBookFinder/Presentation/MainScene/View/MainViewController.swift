//
//  MainViewController.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import UIKit

import SnapKit

private enum Const {
    static let navigationTitlt = "Book Finder"
}

final class MainViewController: UIViewController {
    private let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.text = Const.navigationTitlt
        
//        let largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
//        label.attributedText = NSAttributedString(
//            string: Const.navigationTitlt,
//            attributes: [.foregroundColor: ColorPalette.malrangPink, .font: largeTitleFont]
//        )
        return label
    }()

    private let searchView: SearchView

    init(searchViewModel: SearchViewModelable, coordinator: MainViewCoordinatorProtocol) {
        self.searchView = SearchView(
            searchViewModel: searchViewModel,
            coordinator: coordinator
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItem()
        self.setupView()
        self.setupConstraint()
    }

    private func setupNavigationItem() {
        self.navigationItem.titleView = self.navigationTitleLabel
    }

    private func setupView() {
        self.view.backgroundColor = ColorPalette.malrangPink
        self.view.addSubview(self.searchView)
    }

    private func setupConstraint() {
        self.searchView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
