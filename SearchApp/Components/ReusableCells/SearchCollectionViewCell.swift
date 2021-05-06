//
//  SearchCollectionViewCell.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    var searchItemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    var searchItemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var searchItemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var searchItemReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(searchItemImageView)
        addSubview(searchItemNameLabel)
        addSubview(searchItemPriceLabel)
        addSubview(searchItemReleaseDateLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchItemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            searchItemImageView.widthAnchor.constraint(equalToConstant: 125),
            searchItemImageView.heightAnchor.constraint(equalToConstant: 100),
            searchItemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            searchItemNameLabel.topAnchor.constraint(equalTo: searchItemImageView.bottomAnchor, constant: 10),
            searchItemNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchItemNameLabel.widthAnchor.constraint(equalToConstant: 150),
            searchItemNameLabel.bottomAnchor.constraint(equalTo: searchItemPriceLabel.topAnchor, constant: -10),
            
            searchItemPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            searchItemPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            searchItemReleaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            searchItemReleaseDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
