//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    // MARK: - Properties -
    
    private var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = StaticTexts.searchText
        bar.scopeButtonTitles = SearchBarScopeType.allCases.map { $0.scopeTitle }
        bar.selectedScopeButtonIndex = 0
        bar.showsScopeBar = true
        bar.showsCancelButton = true
        return bar
    }()
    private var searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setCollectionViewLayout(layout, animated: true)
        view.backgroundColor = .clear
        view.backgroundView = UIView.init(frame: .zero)
        return view
    }()
    private var searchViewModel = SearchViewModel()
    private var selectedScopeType: String = SearchBarScopeType.movie.rawValue
    private var searchedText: String = ""
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    // MARK: - Lifecycles -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Methods -
    
    private func setupView() {
        view.backgroundColor = .white
        addSubviews()
        setupConstraints()
        setupCollectionView()
        setupSearchBar()
        setupToolbar()
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchCollectionView.topAnchor),
            
            searchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: StaticTexts.searchCollectionViewCellID)
        searchCollectionView.keyboardDismissMode = .onDrag
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: StaticTexts.doneText, style: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([space, doneButton], animated: true)
        toolbar.sizeToFit()
        searchBar.inputAccessoryView = toolbar
    }
    
    /// Reset collection view and searchedText.
    private func resetCollectionView() {
        searchedText = ""
        searchViewModel.resetSearchTypes()
        searchCollectionView.reloadData()
    }
    
    /// Reload collection view with the searched text and selected scope type.
    private func reloadCollectionView() {
        searchViewModel.getSearchResultData(term: searchedText, media: selectedScopeType)
        searchViewModel.listenSearchResultCallback { [weak self] in
            guard let self = self else { return }
            self.searchCollectionView.reloadData()
        }
    }
    
    /// Get movie, music, app and book datas with searched text.
    private func search(with text: String?) {
        guard let text = text else { fatalError() }
        resetCollectionView()
        searchedText = text
        reloadCollectionView()
    }
    
    /// Dismiss the keyboard.
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Actions -
    
    @objc func doneButtonTapped() {
        dismissKeyboard()
    }
}

// MARK: - SearchViewController: UISearchBarDelegate -

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pendingRequestWorkItem?.cancel()
        if searchText.count > 2 {
            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.search(with: searchText)
            }
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: requestWorkItem)
        } else {
            resetCollectionView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(with: searchBar.text)
        dismissKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        resetCollectionView()
        dismissKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedScopeType = SearchBarScopeType.allCases[selectedScope].rawValue
        searchBarSearchButtonClicked(searchBar)
    }
}

// MARK: - SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticTexts.searchCollectionViewCellID, for: indexPath) as? SearchCollectionViewCell {
            let resultModel = searchViewModel.searchResultList[indexPath.row]
            cell.updateUI(nameText: resultModel.name,
                          priceText: resultModel.price,
                          releaseDateText: resultModel.releaseDate,
                          imageURL: resultModel.imageURL,
                          indicator: SDWebImageActivityIndicator.gray)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.detailViewModel = DetailViewModel(searchItemModel: searchViewModel.searchResultList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // If "searchResultList.count" is less than "searchViewModel.pageItemLimit * searchViewModel.pageCount", don't search.
        if searchViewModel.searchResultList.count == searchViewModel.pageItemLimit * searchViewModel.pageCount {
            if indexPath.row == searchViewModel.searchResultList.count - 1 {
                searchViewModel.increasePageCount()
                reloadCollectionView()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
