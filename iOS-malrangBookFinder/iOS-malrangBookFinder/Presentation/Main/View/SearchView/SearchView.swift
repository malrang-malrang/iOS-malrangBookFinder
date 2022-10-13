//
//  SearchView.swift
//  iOS-malrangBookFinder
//
//  Created by 김동욱 on 2022/10/12.
//

import RxCocoa
import RxSwift
import SnapKit

private enum Const {
    static let searchBarPlaceholder = "어떤책을 찾고 있나요?"
    static let searchResultCount = "검색 결과 527 권"
}

final class SearchView: UIView {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Const.searchBarPlaceholder
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    private let searchResultCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()

    private let searchResultCountLabel: UILabel = {
        let label = UILabel()
        label.text = Const.searchResultCount
        return label
    }()

    private let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(
            SearchResultCell.self,
            forCellReuseIdentifier: SearchResultCell.identifier
        )
        return tableView
    }()

    private let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupConstraint()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .systemBackground
        self.addSubviews(
            self.searchBar,
            self.searchResultCountView,
            self.searchResultTableView
        )
        self.searchResultCountView.addSubview(self.searchResultCountLabel)
    }

    private func setupConstraint() {
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        self.searchResultCountView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom).offset(1)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(20)
        }

        self.searchResultCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }

        self.searchResultTableView.snp.makeConstraints {
            $0.top.equalTo(self.searchResultCountView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func bind() {
        let sampleData = NSDataAsset(name: "GoogleBooksSampleData")
            .map { $0.data }!

        Observable.of(sampleData)
            .decode(type: SearchResultDTO.self, decoder: Json.decoder)
            .compactMap { $0.items }
            .bind(to: self.searchResultTableView.rx.items) { tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultCell.identifier,
                    for: IndexPath(row: row, section: .zero)
                ) as? SearchResultCell else {
                    return UITableViewCell()
                }

                let cellViewModel = SearchResultCellViewModel(bookInformation: element.toDomain())
                cell.bind(viewModel: cellViewModel)

                return cell
            }
            .disposed(by: self.disposeBag)

        self.searchResultTableView.rx.itemSelected
            .withUnretained(self)
            .subscribe(onNext: { searchView, indexPath in
                searchView.searchResultTableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
