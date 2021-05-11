//
//  SearchCollectionViewCell.swift
//  SearchApp
//
//  Created by Cem Kazım on 5.05.2021.
//

import UIKit
import SDWebImage

class SearchCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties -
    
    private var searchItemImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    private var searchItemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private lazy var searchItemLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [searchItemPriceLabel, searchItemReleaseDateLabel])
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private var searchItemPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    private var searchItemReleaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = .zero
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initialize -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods -
    
    private func setup() {
        addSubview(searchItemImageView)
        addSubview(searchItemNameLabel)
        addSubview(searchItemLabelStackView)
        setUI()
        setupConstraints()
    }
    
    private func setUI() {
        layer.shadowOffset = CGSize(width: 1, height: 0)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.4
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchItemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            searchItemImageView.widthAnchor.constraint(equalToConstant: 100),
            searchItemImageView.heightAnchor.constraint(equalToConstant: 100),
            searchItemImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            searchItemNameLabel.topAnchor.constraint(equalTo: searchItemImageView.bottomAnchor, constant: 10),
            searchItemNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchItemNameLabel.widthAnchor.constraint(equalToConstant: 150),
            searchItemNameLabel.bottomAnchor.constraint(equalTo: searchItemPriceLabel.topAnchor, constant: -10),
            
            searchItemLabelStackView.topAnchor.constraint(equalTo: searchItemNameLabel.bottomAnchor, constant: 10),
            searchItemLabelStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func updateUI(nameText: String?, priceText: String?, releaseDateText: String?, imageURL: URL?, indicator: SDWebImageActivityIndicator) {
        searchItemImageView.sd_imageIndicator = indicator
        searchItemImageView.sd_setImage(with: imageURL)
        searchItemNameLabel.text = nameText
        searchItemPriceLabel.text = priceText
        searchItemReleaseDateLabel.text = releaseDateText
    }
}
