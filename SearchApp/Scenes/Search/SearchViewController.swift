//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.placeholder = StaticTexts.searchText
        bar.scopeButtonTitles = [""]
        bar.selectedScopeButtonIndex = 0
        return bar
    }()
    var searchCollectionView: UICollectionView = {
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
    var searchViewModel = SearchViewModel()
    var searchedText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        addSubviews()
        setupConstraints()
        view.backgroundColor = .white
        searchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: StaticTexts.searchCollectionViewCellID)
    }
    
    func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
    }
    
    func setupConstraints() {
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

extension SearchViewController: UISearchBarDelegate {
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StaticTexts.searchCollectionViewCellID, for: indexPath) as? SearchCollectionViewCell {
            cell.searchItemImageView.image = UIImage()
            cell.searchItemNameLabel.text = "Dark Side Of The Moon (Pink Floyd)"
            cell.searchItemPriceLabel.text = "25$"
            return cell
        } else {
            return UICollectionViewCell()
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
