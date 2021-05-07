//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
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
    private var loaderView = UIActivityIndicatorView(style: .large)
    private var selectedScopeType: String = ""
    private var searchBarText: String = ""
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        addSubviews()
        setupConstraints()
        setupCollectionView()
        setupLoaderView()
        setupSearchBar()
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        view.addSubview(loaderView)
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
    
    private func setupLoaderView() {
        loaderView.center = view.center
        loaderView.startAnimating()
        hideLoader()
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
}

extension SearchViewController {
    
    private func resetCollectionView() {
        searchViewModel.searchResultList.removeAll()
        searchCollectionView.reloadData()
    }
    
    private func reloadCollectionView() {
        showLoader()
        searchViewModel.getSearchResultData(term: searchBarText, media: selectedScopeType)
        searchViewModel.listenSearchResultCallback { [weak self] in
            guard let self = self else { return }
            self.searchCollectionView.reloadData()
            self.hideLoader()
        }
    }
    
    private func showLoader() {
        loaderView.isHidden = false
    }
    
    private func hideLoader() {
        loaderView.isHidden = true
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchedText = searchBar.text else { return }
        pendingRequestWorkItem?.cancel()
        switch searchedText.count {
        case let x where x > 2:
            let requestWorkItem = DispatchWorkItem { [weak self] in
                guard let self = self else { return }
                self.searchBarSearchButtonClicked(searchBar)
            }
            pendingRequestWorkItem = requestWorkItem
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: requestWorkItem)
        default:
            resetCollectionView()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resetCollectionView()
        searchBarText = searchBar.text ?? ""
        reloadCollectionView()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBarText = ""
        resetCollectionView()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        selectedScopeType = SearchBarScopeType.allCases[selectedScope].rawValue
        resetCollectionView()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticTexts.searchCollectionViewCellID, for: indexPath) as? SearchCollectionViewCell {
            cell.searchItemImageView.sd_setImage(with: searchViewModel.searchResultList[indexPath.row].imageURL, completed: nil)
            cell.searchItemNameLabel.text = searchViewModel.searchResultList[indexPath.row].name
            cell.searchItemPriceLabel.text = searchViewModel.searchResultList[indexPath.row].price
            cell.searchItemReleaseDateLabel.text = searchViewModel.searchResultList[indexPath.row].releaseDate
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
        if indexPath.row == searchViewModel.searchResultList.count - 1 {
            searchViewModel.pageCount += 1
            reloadCollectionView()
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
