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
        view.layer.cornerRadius = view.frame.size.width / 8
        view.contentMode = .scaleAspectFill
        return view
    }()
    var searchItemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    var searchItemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
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
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchItemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            searchItemImageView.widthAnchor.constraint(equalToConstant: 150),
            searchItemImageView.heightAnchor.constraint(equalToConstant: 125),
            searchItemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            searchItemNameLabel.topAnchor.constraint(equalTo: searchItemImageView.bottomAnchor, constant: 10),
            searchItemNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchItemNameLabel.widthAnchor.constraint(equalToConstant: 150),
            searchItemNameLabel.bottomAnchor.constraint(equalTo: searchItemPriceLabel.topAnchor, constant: -10),
            
            searchItemPriceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchItemPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
