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
    static let searchResultCount = "검색 결과 %d 권"
}

final class SearchView: UIView {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Const.searchBarPlaceholder
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.tintColor = ColorPalette.malrangDeepPink
        searchBar.searchTextField.backgroundColor = .white
        return searchBar
    }()

    private let resultCountView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()

    private let resultCountLabel: UILabel = {
        let label = UILabel()
        label.text = Const.searchResultCount
        return label
    }()

    private let resultTableView: UITableView = {
        let tableView = UITableView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(
            SearchResultCell.self,
            forCellReuseIdentifier: SearchResultCell.identifier
        )
        return tableView
    }()

    private let loadingIndicator = LoadingIndicatorView()
    private let coordinator: MainViewCoordinatorProtocol
    private let viewModel: SearchViewModelable
    private let disposeBag = DisposeBag()

    init(searchViewModel: SearchViewModelable, coordinator: MainViewCoordinatorProtocol) {
        self.viewModel = searchViewModel
        self.coordinator = coordinator
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.setupView()
        self.setupConstraint()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = ColorPalette.malrangPink
        self.addSubviews(
            self.searchBar,
            self.resultCountView,
            self.resultTableView,
            self.loadingIndicator
        )
        self.resultCountView.addSubview(self.resultCountLabel)
    }

    private func setupConstraint() {
        self.searchBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(15)
        }

        self.resultCountView.snp.makeConstraints {
            $0.top.equalTo(self.searchBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(20)
        }

        self.resultCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }

        self.resultTableView.snp.makeConstraints {
            $0.top.equalTo(self.resultCountView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        self.loadingIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().dividedBy(2)
        }
    }

    private func bind() {
        // MARK: - Error

        self.viewModel.error
            .observe(on: MainScheduler.instance)
            .bind { [weak self] error in
                self?.coordinator.showErrorAlert(
                    title: error.identifier,
                    message: error.errorMessage
                )
            }
            .disposed(by: self.disposeBag)

        // MARK: - SearchBar

        self.searchBar.searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind { [weak self] _ in
                self?.endEditing(true)
            }
            .disposed(by: disposeBag)

        self.searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind { [weak self] text in
                self?.viewModel.fetchFirstPage(text: text)
            }
            .disposed(by: self.disposeBag)

        // MARK: - TableView

        self.viewModel.bookInformationList
            .observe(on: MainScheduler.instance)
            .bind(to: self.resultTableView.rx.items) { tableView, row, element in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultCell.identifier,
                    for: IndexPath(row: row, section: .zero)
                ) as? SearchResultCell else {
                    return UITableViewCell()
                }

                let cellViewModel = SearchResultCellViewModel(bookInformation: element)
                cell.bind(viewModel: cellViewModel)

                return cell
            }
            .disposed(by: self.disposeBag)

        self.viewModel.totalItems
            .observe(on: MainScheduler.instance)
            .map { String(format: Const.searchResultCount, $0) }
            .bind(to: self.resultCountLabel.rx.text)
            .disposed(by: self.disposeBag)

        Observable.zip(
            self.resultTableView.rx.itemSelected,
            self.resultTableView.rx.modelSelected(BookInformation.self)
        )
        .bind { [weak self] (indexPath, bookInformation) in
            self?.coordinator.showDetailView(bookInformation: bookInformation)
            self?.resultTableView.deselectRow(at: indexPath, animated: true)
        }
        .disposed(by: self.disposeBag)

        self.resultTableView.rx.prefetchRows
            .bind { [weak self] indexPath in
                self?.viewModel.fetchNextPage(lastRow: indexPath.last?.row)
            }
            .disposed(by: self.disposeBag)

        // MARK: - loadingIndicator

        self.viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .bind { [weak self] isLoading in
                switch isLoading {
                case true:
                    self?.loadingIndicator.startAnimating()
                case false:
                    self?.loadingIndicator.stopAnimating()
                }
            }
            .disposed(by: self.disposeBag)
    }
}
